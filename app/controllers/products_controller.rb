class ProductsController < ApplicationController
    include CategoryHelper

    def index
        @products = Product::where(user_id: 2)
    end

    def new
        @product = Product.new

        @inventory = Inventory 

        # render plain:list_categories
    end

    def show
        @product    = Product.find(params[:id])
        @inventory  = @product.inventory
        # render plain:@inventory.inspect
    end

    def edit
        @product    = Product.find(params[:id])
        @inventory  = @product.inventory
    end

    def update
        @product    = Product.find(params[:id])
        @product.update(resource_params)

        @inventory          = @product.inventory.update(stock: params[:product][:inventory][:stock])

        redirect_to products_path
        
        # old_desc = @Book.description

       

        # @Book.update(param)
        # flash[:notice] = "Book with ID #{params[:id]} has been updated"

        # redirect_to book_path(@Book)

    end
    
    def create
        @product            = Product.new(resource_params) 
        @product[:user_id]  = current_user.id
        @product.save

        @inventory          = Inventory.create(product_id: @product[:id], stock: params[:product][:inventory][:stock])

        # book        = Book.new(title: title, description: description, 
        #                 page: page, price: price)
        
        # @book        = Book.new(resource_params) 
        

        render plain:@inventory.inspect
    end

    def destroy
        @product = Product.find(params[:id])

        @inventory = @product.inventory

        # render plain: @inventory.inspect

        @product.destroy

        @inventory.destroy
        
        
        redirect_to products_path, status: :see_other
    end

    private
    def resource_params
        params.require(:product).permit(:name, :description, :image, :category_id, :price, :user_id, :weight, :condition, :inventories)

    end

end