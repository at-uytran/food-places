class NearbyPlacesController < ApplicationController
  def index
    if user_location_present?
      coordinates = [current_user.user_location.latitude, current_user.user_location.longitude]
    else
      coordinates = [current_location.latitude, current_location.longitude]
    end
    @locations = Location.near(coordinates,
      5, units: :km).created_desc.with_approve_place
      .includes(:place).page(params[:page]).per_page 9
  end

  private

  def user_location_present?
    current_user && current_user.user_location && current_user.user_location.latitude && current_user.user_location.longitude
  end
end
