class PlacesController < ApplicationController
  before_action :load_place, only: %i(show update destroy)
  before_action :set_json_params, only: %i(index)
  before_action :logged_in_user, only: %i(new create destroy update)

  def index
    @q = Place.search params[:q]
    @places = @q.result.created_desc.by_categories(@category_ids).page(params[:page]).per_page(9)
  end

  def create
    @place = Place.new place_params
    if @place.save
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
  end

  private

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
