class Merchant::UsersController < Merchant::BaseController

  def show
    @merchant = User.find(params[:format])
    @orders = Order.merchant_orders(@merchant)
    @items = Item.merchant_items(current_user)
    @users = User.top_consumers(current_user)
  end

end
