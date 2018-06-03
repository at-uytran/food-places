class OwnerPlacesController < ApplicationController
  before_action :load_place, only: %i(edit update destroy)
  before_action :valid_user!, only: %(edit update destroy)

  def index
    @owner_places = current_user.places.page(params[:page]).per_page 9
  end

  def edit

  end

  def update
    debugger
    if @owner_place.update_attributes owner_place_params
      flash[:success] =  t ".success"
      redirect_to :owner_places_path
    else
      flash[:danger] = t ".failed"
      render :edit
    end
  end

  private

  def owner_place_params
    params.require(:place).permit :name, :address, :description, :district_id, :owner_id,
      :image, :open_time, :close_time, :ship_price, :coordinates, :status, :place_category_id, :table_count
  end

  def load_place
    @owner_place = Place.find_by id: params[:id]
    return if @owner_place
    flash[:danger] = t "places.load_place.not_found"
  end

  def valid_user!
    return if @place.owner == current_user
    flash[:danger] = t "owner_places.valid_user.not_owner"
    redirect_to root_path
  end
end
