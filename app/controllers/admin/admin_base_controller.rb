module Admin
  class AdminBaseController < ActionController::Base
    protect_from_forgery with: :exception
    layout "application_admin"
    before_action :verify_admin!

    include SessionsHelper

    private

    def logged_in_user
      return if logged_in?
      store_location
      flash[:danger] = I18n.t "required_login"
      redirect_to root_path
    end

    def verify_admin!
      return if current_user && current_user.admin?
      flash[:danger] = t "verify_admin"
      redirect_to root_path
    end
  end
end
