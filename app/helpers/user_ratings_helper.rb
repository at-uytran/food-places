module UserRatingsHelper
  def switch_review_form
    return if current_user
    "switch"
  end
end
