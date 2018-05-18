module Admin
  class PlacesController < AdminBaseController
    before_action :load_place, except: %i(index create new)

    def create; end

    def index
      @q = Place.search params[:q]
      @places = @q.result.created_desc.page(params[:page]).per_page 9
    end

    def update
      if @place.update_attributes place_params
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".failed"
      end
      redirect_back fallback_location: admin_root_path
    end

    def new
      @place = Place.new
    end

    def destroy
      if @place.destroy!
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".failed"
      end
    end

    private

    def place_params
      params.require(:place).permit :name, :address, :descriptions, :location_id, :owner, :email, :phone, :facebook, :table_count, :image_url, :open_time, :close_time, :ship_price, :coordinates, :status, :place_category_id
    end

    def load_place
      @place = Place.find_by id: params[:id]
      return if @place
      flash[:danger] = t ".admin.places.load_place.not_found"
      redirect_to admin_root_path
    end
  end
end
