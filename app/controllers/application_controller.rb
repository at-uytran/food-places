class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def current_location
    if Rails.env.development?
      geo_data = Geocoder.search("116.110.21.32")
    else
      geo_data = Geocoder.search(request.remote_ip)
    end
    geo_data[0]
  end

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = I18n.t "required_login"
    redirect_to root_path
  end
end
