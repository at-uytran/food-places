class UserRatingsController < ApplicationController
  before_action :load_place, only: :create

  def create
    debugger
    @user_rating = @place.user_ratings.new user_rating_params
    if @user_rating.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    respond_to do |format|
      format.html{redirect_back fallback_location: root_path}
      format.js
    end
  end

  private

  def load_place
    debugger
    @place = Place.find_by id: params[:place_id]
    return if @place
    flash[:danger] = t ".not_found"
    redirect_back fallback_location: root_path
  end

  def user_rating_params
    params.require(:user_rating).permit :user_id, :place_id, :content, :points, :title
  end
end
