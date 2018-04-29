module PlacesHelper
  def rate_point place
    return I18n.t("places.rating_average.n_a") if place.user_ratings.blank?
    place.user_ratings.each do |rating|
      @points += rating.point
    end
    @points / place.user_ratings.size
  end
end
