class PlacesController < ApplicationController
  before_action :load_place, only: %i(show update destroy)
  before_action :set_json_params, only: %i(index)
  before_action :logged_in_user, only: %i(new create destroy update)
  before_action :check_district_params, only: :create

  def index
    @q = Place.search params[:q]
    @places = @q.result.approved.created_desc.includes(:place_category)
      .by_categories(@category_ids).page(params[:page]).per_page(9)
  end

  def create
    @place = Place.new place_params
    if @place.save
      @place.create_location! district_id: params[:location][:district_id], address: params[:place][:address]
      flash[:success] = t ".success"
      redirect_to root_path
    else
      flash[:danger] = t ".failed"
      render :new
    end
  end

  def new
    @place = Place.new
  end

  def show
    @foods = @place.foods.limit 9
    @reviews = @place.user_ratings.includes(:user).limit 9
    @order = current_user.orders.find_by place_id: @place.id if current_user
    respond_to do |format|
      format.html
      format.json{render json: {addresses: @place.location}}
    end
  end

  private

  def check_district_params
    return if params[:location][:district_id].present?
    flash[:danger] = t "places.check_district_params.require_district"
    redirect_back fallback_location: places_path
  end

  def set_json_params
    @category_ids = params[:category_ids].present? ? JSON.parse(params[:category_ids]) : []
  end

  def place_params
    params.require(:place).permit :name, :address, :description, :location_id, :owner_id,
      :image, :open_time, :close_time, :ship_price, :coordinates, :status, :place_category_id, :table_count
  end

  def load_place
    @place = Place.find_by id: params[:id]
    return if @place
    flash[:danger] = t "places.load_place.not_found"
    redirect_to root_path
  end
end
