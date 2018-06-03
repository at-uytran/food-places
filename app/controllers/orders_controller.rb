class OrdersController < ApplicationController
  before_action :load_order, only: :update
  add_breadcrumb I18n.t("bread_crumb.home"), "/"

  def index
    add_breadcrumb t("bread_crumb.orders"), orders_path
    @orders = current_user.orders.page(params[:page]).per_page(9)
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".failed"
    end
    redirect_back fallback_location: places_path
  end

  private

  def update_values
    # @order.distance =
  end

  def load_order
    @order = Order.find_by id: params[:id]
  end

  def order_params
    params.require(:order).permit :address, :status, :place_id, :user_id, :distance
  end
end
