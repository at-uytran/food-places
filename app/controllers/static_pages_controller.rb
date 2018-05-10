class StaticPagesController < ApplicationController
  def home
    @allow_order_places = Place.allow_order.created_desc.includes(:place_category).limit 10
    @top_order_places = Place.allow_order.created_desc.includes(:place_category).limit 10
    if current_user && current_user.user_location
      @nearby_locations = Location.near([current_user.user_location.latitude, current_user.user_location.longitude],
        5, units: :km).created_desc
        .includes(:place).limit 4
    else
      @nearby_locations = Location.near([current_location.latitude, current_location.longitude],
        5, units: :km).created_desc
        .includes(:place).limit 4
    end
  end
end
