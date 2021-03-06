class UsersController < ApplicationController
  before_action :load_user, except: %i(index create show)
  add_breadcrumb I18n.t("bread_crumb.home"), "/"

  def index
    @users = User.order_by_name
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    respond_to do |format|
      format.html{redirect_back fallback_location: root_path}
      format.js
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_back fallback_location: root_path
    else
      flash[:danger] = t ".failed"
      render :show
    end
  end

  def show
    @user = current_user
    add_breadcrumb t("bread_crumb.users"), users_path
    add_breadcrumb t("bread_crumb.detail"), user_path(@user)
    respond_to do |format|
      format.html
      format.json{render json: {address: @user.user_location}}
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
    params.require(:user).permit :name, :email, :password, :phone, :district_id,
      :password_confirmation, :address, :avatar, :descriptions
  end
end
