class ProductsController < ApplicationController
    def index
        @products = Product::all
        # render plain:@products.inspect
    end

    def show
        @product = Product::find(params[:id])
        # render plain:@product.inspect
    end

end