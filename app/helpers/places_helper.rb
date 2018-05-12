module PlacesHelper
  def rate_point place
    return I18n.t("places.rating_average.n_a") if place.user_ratings.blank?
    place.user_ratings.each do |rating|
      @points += rating.points
    end
    @points / place.user_ratings.size
  end

  def list_place_categories
    PlaceCategory.all.order_name
  end

  def list_provinces
    Province.all.includes(:districts)
  end

  def list_category
    PlaceCategory.all.collect{|key| [key.name, key.id]}
  end

  def place_address place
    return place.address if place.address
    t ".places.no_address"
  end

  def place_descriptions place
    return place.descriptions if place.descriptions
    t ".places.no_descriptions"
  end

  def ship_price place
    return place.ship_price if place.ship_price
    t "updating"
  end

  def distance_from_here place
    return "#{place.location.distance_from([current_location.latitude, current_location.longitude]).round(2)} km" if place.location
    t "updating_location"
  end

  def show_phone place
    return place.phone if place.phone
    t "updating"
  end

  def show_email place
    return place.email if place.email
    t "updating"
  end
end
