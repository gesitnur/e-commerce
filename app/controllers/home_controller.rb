class HomeController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index]
  
  def index
      # debugger
      @products = Product::all

    # OrderItem.create(order_id: 292, product_id: 3, qty: 1, total: 600000)

    # Product.reset_counters(3, :order_items)

      # render plain:@categories.inspect
  end

  def show
      @product = Product::find(params[:id])
      # render plain:@product.inspect
  end

  def p
      @products = Product::where(category_id: params[:id])

      render 'index'

      # render plain:@products.inspect
  end
end
