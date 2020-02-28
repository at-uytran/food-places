class StaticPagesController < ApplicationController
  def home
    @allow_order_places = Place.allow_order.approved.created_desc.includes(:place_category).limit 10
    @top_order_places = Place.orders_desc.approved.created_desc.includes(:place_category).limit 10
    if current_user && current_user.address
      coordinates = [current_user.latitude, current_user.longitude]
    else
      if current_location.present?
        coordinates = [current_location[:latitude], current_location[:longitude]]
      else
        coordinates = [0, 0]
      end
    end
    @nearby_places = Place.near(coordinates,
      5, units: :km).created_desc.approved
      .limit 4
    @reviews = UserRating.created_desc.limit 4
  end
end
