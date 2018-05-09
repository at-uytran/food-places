class StaticPagesController < ApplicationController
  def home
    if current_user
      @nearby_locations = Location.near([current_user.user_location.latitude, current_user.user_location.longitude],
        5, units: :km).created_desc
        .includes(:place).limit 4
    end
  end
end
