class HomeController < ApplicationController
  def index
      @products = Product::all
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
