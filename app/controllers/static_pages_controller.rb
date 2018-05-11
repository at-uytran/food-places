class StaticPagesController < ApplicationController
  def home
    @allow_order_places = Place.allow_order.approved.created_desc.includes(:place_category).limit 10
    @top_order_places = Place.orders_desc.approved.created_desc.includes(:place_category).limit 10
    if current_user && current_user.user_location
      coordinates = [current_user.user_location.latitude, current_user.user_location.longitude]
    else
      coordinates = [current_location.latitude, current_location.longitude]
    end
    @nearby_locations = Location.near(coordinates,
      5, units: :km).created_desc.with_approve_place
      .includes(:place).limit 4
  end
end
