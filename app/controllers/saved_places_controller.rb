class SavedPlacesController < ApplicationController
  before_action :load_saved_place, only: :destroy

  def index
    @saved_places = current_user.saved_places.page(params[:page]).per_page 9
  end

  def create
    @saved_place = SavedPlace.create user_id: params[:user_id], place_id: params[:place_id]
    if @saved_place
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    respond_to do |format|
      format.js
      format.html{redirect_back fallback_location: places_path}
    end
  end

  def destroy
    @saved_place = SavedPlace.find_by id: params[:id]
    return unless @saved_place
    @place = @saved_place.place
    respond_to do |format|
      if @saved_place.destroy
        format.html
        format.js{flash.now[:success] = t ".unsaved"}
      else
        redirect_to @place
      end
    end
    @saved_place.destroy
  end

  private

  def saved_place_params
    params.require(:saved_place).permit(:user_id, :place_id)
  end

  def load_saved_place
    @saved_place = SavedPlace.find_by id: params[:id]
  end
end
