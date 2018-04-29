class ProvincesController < ApplicationController
  before_action :load_province, only: :show

  def show
    render json: {data: {province: @province, districts: @province.districts}}
  end

  private

  def load_province
    @province = Province.find_by id: params[:id]
  end
end
