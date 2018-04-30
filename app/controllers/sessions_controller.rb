class SessionsController < ApplicationController
  CHECKED_REMEMBER = Settings.sessions.checked_remember.to_s
  before_action :set_user, only: :create

  def new; end

  def create
    if @user && @user.authenticate(params[:session][:password])
      remember_user
    else
      flash.now[:danger] = t ".failed"
    end
    respond_to do |format|
      format.html{redirect_back fallback_location: root_path}
      format.js
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def remember_user
    log_in @user
    params[:session][:remember_me] == CHECKED_REMEMBER ? remember(@user) : forget(@user)
    flash.now[:success] = t "sessions.remember_user.success"
  end

  def set_user
    @user = User.find_by(email: params[:session][:email].downcase)
  end
end
