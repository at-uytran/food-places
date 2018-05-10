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
    if current_user && current_user.user_location.address
      geo_data = Geocoder.search(current_user.user_location.address)
    else
      geo_data = Geocoder.search(request.remote_ip)
    end
    geo_data[0]
  end

  def admin_user? user
    user.admin?
  end
end
