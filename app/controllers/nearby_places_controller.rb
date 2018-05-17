class NearbyPlacesController < ApplicationController
  def index
    if user_location_present?
      coordinates = [current_user.latitude, current_user.longitude]
    else
      coordinates = [current_location.latitude, current_location.longitude]
    end
    @nearby_places = Place.near(coordinates,
      5, units: :km).created_desc.approved
      .page(params[:page]).per_page 9
  end

  private

  def user_location_present?
    current_user && current_user.address && current_user.latitude && current_user.longitude
  end
end
