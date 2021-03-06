class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include ApplicationHelper

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = I18n.t "required_login"
    redirect_to root_path
  end
end
