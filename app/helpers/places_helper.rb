module PlacesHelper
  def rate_point place
    return I18n.t("places.rating_average.n_a") if place.user_ratings.blank?
    place.user_ratings.each do |rating|
      @points += rating.point
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
    place.address if place.address
    t ".places.no_address"
  end

  def place_descriptions place
    place.descriptions if place.descriptions
    t ".places.no_descriptions"
  end

  def ship_price place
    place.ship_price if place.ship_price
    t "updating"
  end
end
