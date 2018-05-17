class StaticPagesController < ApplicationController
  def home
    @allow_order_places = Place.allow_order.approved.created_desc.includes(:place_category).limit 10
    @top_order_places = Place.orders_desc.approved.created_desc.includes(:place_category).limit 10
    if current_user && current_user.address
      coordinates = [current_user.latitude, current_user.longitude]
    else
      coordinates = [current_location.latitude, current_location.longitude]
    end
    @nearby_places = Place.near(coordinates,
      5, units: :km).created_desc.approved
      .limit 4
  end
end
