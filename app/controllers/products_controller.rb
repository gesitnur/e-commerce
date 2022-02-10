class ProductsController < ApplicationController
    
    before_action :authenticate_user!
    before_action :find_product
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
        @inventory  = @product.inventory
        @history    = @product.stock_history
        
        # render plain: @history.inspect

        # render plain:@inventory.inspect
    end

    def edit ;end

    def update
        
        render plain:@product.update_product_and_stock(resource_params)

        # render plain:resource_params


        # # render plain: resource_params
        # if @product.update(resource_params)
        #     redirect_to products_path
        # else
        #     redirect_to products_path
        #     flash[:notice] = @product.errors.full_messages
        # end

    end

    def update_stock

        render plain: params

        stock       = @product.inventory.stock

        # if @product.inventory.update(stock: params[:new_stock] )
        
        #     action = stock > params[:new_stock].to_i ? 'Pengurangan Stok' : 'Penambahan Stok'
            
        #     Product.make_log(@product, stock, params[:new_stock].to_i - stock, action)

        #     render json: { success: 'success' }

        # else
        #     render json: { error: @product.inventory.errors.full_messages }
        # end

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
        if @product.destroy
            redirect_to products_path, status: :see_other
        else
            flash[:notice] = @product.errors.full_messages
            redirect_to products_path, status: :see_other
        end
   
    end

    private
    def resource_params
        params.require(:product).permit(:name, :description, :image, :category_id, :price, :user_id, :weight, :condition, inventory_attributes: [:id, :stock])

    end

    def find_product
        @product    = Product.find(params[:id])
    end

end