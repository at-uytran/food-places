class UserPlaceOrdersController < ApplicationController
  before_action :load_place, only: :update
  before_action :load_order, only: :update

  def update
    if params[:user_place_order].blank?
      @order.destroy!
    else
      @order.carts.destroy_all
      params[:user_place_order].each do |key, value|
        @order.carts.create food_id: key.to_i, quantity: value.to_i
        @order.save
      end
    end
  end

  private

  def load_order
    load_place
    @order = current_user.orders.find_by place_id: @place.id
    return if @order
    @order = current_user.orders.create place_id: @place.id
  end

  def load_place
    @place = Place.find_by id: params[:id]
    return if @place
    flash.now[:danger] = t ".not_found"
    redirect_to places_path
  end

  def user_place_order_params
    params.require :user_place_order
  end
end
