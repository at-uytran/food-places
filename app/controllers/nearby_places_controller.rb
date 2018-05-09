class NearbyPlacesController < ApplicationController
  def index
    if current_user
      @locations = Location.near([current_user.user_location.latitude, current_user.user_location.longitude],
        5, units: :km).created_desc
        .includes(:place).page(params[:page]).per_page 9
    end
  end
end
