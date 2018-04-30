class UsersController < ApplicationController
  before_action :load_user, except: %i(index create)

  def index
    @users = User.order_by_name
  end

  def create
    @user = User.new user_params
    if @user.save
      flash.now[:success] = t ".success"
    else
      flash.now[:danger] = t ".failed"
    end
    respond_to do |format|
      format.html{redirect_back fallback_location: root_path}
      format.js
    end
  end

  def update
    if @user.update_attributes user_params
      flash.now[:success] = t ".success"
      redirect_back fallback_location: root_path
    else
      flash.now[:danger] = t ".failed"
      render :edit
    end
  end

  def edit; end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash.now[:danger] = t ".not_found"
    redirect_back fallback_location: root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :address, :avatar, :coordinates, :descriptions
  end
end
