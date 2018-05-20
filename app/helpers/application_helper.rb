module ApplicationHelper
  def active_class? path
    return "active" if request.path == path
  end

  def locale_time time
    return l time, format: :show if time
    t "updating"
  end

  def locale_date date
    return l date, format: :default if date
    t "updating"
  end

  def current_location
    if current_user && current_user.address
      geo_data = Geocoder.search(current_user.address)
    elsif Rails.env.development?
      geo_data = Geocoder.search("Đà Nẵng")
    else
      geo_data = Geocoder.search(request.remote_ip)
    end
    geo_data[0]
  end

  def admin_user? user
    user.admin?
  end

  def create_index params_page, index, per_page
    params_page = 1 if params_page.nil?
    (params_page.to_i - 1) * per_page.to_i + index.to_i + 1
  end

  def total_item_per_category place_category
    place_category.places.approved.size
  end
end
