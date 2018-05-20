class RequestOwnersController < ApplicationController
  def new
    @request_owner = RequestOwner.new
  end

  private

  def request_owner_params
    params.require(:request_owner).permit :image
  end
end
