class PlacesController < ApplicationController
  before_action :load_place, only: %i(show update destroy)

  def index
    @places = Place.created_desc
  end

  def show
    @foods = @place.foods
    @reviews = @place.user_ratings
  end

  private

  def place_params
    params.require(:place).permit :name, :address, :description, :location_id, :owner_id,
      :image_url, :open_time, :close_time, :ship_price, :coordinates, :status, :place_category_id
  end

  def load_place
    @place = Place.find_by id: params[:id]
    return if @place
    flash[:danger] = t "places.load_place.not_found"
    redirect_to root_path
  end
end
