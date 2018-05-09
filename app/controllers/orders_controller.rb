class OrdersController < ApplicationController
  def update
    debugger
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
  end

  def order_params
    params.require(:order).permit :address, :ship_price, :total_price, :status, :place_id, :user_id, :distance
  end
end
