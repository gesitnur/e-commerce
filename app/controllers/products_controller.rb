class ProductsController < ApplicationController
    include CategoryHelper

    def index
        @products = Product::where(vendor_id: current_user.vendor)
    end

    def new
        @product = Product.new

        @product.build_inventory 

        # render plain:list_categories
    end

    def show
        @product    = Product.find(params[:id])
        @inventory  = @product.inventory
        @history    = @product.stock_history
        
        # render plain: @history.inspect

        # render plain:@inventory.inspect
    end

    def edit
        @product    = Product.find(params[:id])
        @inventory  = @product.inventory
    end

    def update
        @product    = Product.find(params[:id])
        @inventory          = @product.inventory.update(stock: params[:product][:inventory][:stock])
        
        if @product.update(resource_params)
            redirect_to products_path
        else
            redirect_to products_path
            flash[:notice] = @product.errors.full_messages
        end


        
        
        # old_desc = @Book.description

       

        # @Book.update(param)
        # flash[:notice] = "Book with ID #{params[:id]} has been updated"

        # redirect_to book_path(@Book)

    end

    def update_stock
        @product    = Product.find(params[:id])
        stock       = @product.inventory.stock

        if stock == params[:new_stock].to_i
            render plain:'aa'
        else

        action = stock > params[:new_stock].to_i ? 'Pengurangan Stok' : 'Penambahan Stok'
        
        Product.make_log(@product, params[:new_stock].to_i - stock, action)
        
        @product.inventory.update(stock: params[:new_stock] )

        end
        # render plain:@product

    end
    
    def create
        @product                = Product.new(resource_params) 
        @product.vendor_id      = current_user.vendor.id


        if @product.save
            redirect_to products_path
        else
            flash[:notice] = @product.errors.full_messages
            redirect_to products_path
        end

        # @product.inventory.new

        # @inventory          = Inventory.create(product_id: @product[:id], stock: params[:product][:inventory][:stock])

        # book        = Book.new(title: title, description: description, 
        #                 page: page, price: price)
        
        
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
        params.require(:product).permit(:name, :description, :image, :category_id, :price, :user_id, :weight, :condition, inventory_attributes: [:stock])

    end

end