class MapsController < ApplicationController
  def show
    if params[:address]
      geo_code = Geocoder.search(params[:place_address])[0]
    else
      geo_code = Geocoder.search(request.remote_ip)[0]
    end
    respond_to do |format|
      format.json{render json: {addresses: geo_code}}
    end
  end
end
