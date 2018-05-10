module Admin
  class PlacesController < AdminBaseController
    def index
      @places = Place.created_desc.page(params[:page]).per_page 9
    end
  end
end
