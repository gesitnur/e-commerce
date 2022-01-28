class ProductsController < ApplicationController
    def index
        @products = Product::all
    end

    def new
        @product = Product.new
    end

    def create
        @product        = Product.new(resource_params) 
        
        @product.save

        render plain:resource_params
    end

    private
    def resource_params
        params.require(:product).permit(:name, :description, :image, :category_id, :price, :user_id, :weight, :condition)
    end

end