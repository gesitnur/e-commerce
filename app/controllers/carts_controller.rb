class CartsController < ApplicationController
    
    before_action :authenticate_user!

    def index
        @cart = current_user.carts
        # render plain:current_user.carts.inspect
    end

    def create

        @old_cart = Cart.where(user_id: current_user.id, product_id: resource_param[:product_id]).first
        # render plain:current_user.vendor ? 'ini adalah vendor' : 'ini bukan vendor'

        product = Product.find(resource_param[:product_id])

        if current_user.has_role?(:vendor)
            if current_user.vendor.products.exists?(resource_param[:product_id])
                redirect_to root_path
                flash[:notice]  = 'Anda tidak bisa membeli produk dari toko sendiri !'
            end
                
        else

            if @old_cart
                @old_cart.update(qty: @old_cart.qty + 1)
            else
                @cart = Cart.new(resource_param)
                @cart.qty = 1
        
                @cart.save
            end
        
            redirect_to carts_path
            
        end

        # flash.alert = "Berhasil Disimpan"
        
        


    end

    def update
        # render plain:
        @cart = Cart.find(params[:id])
        @cart.status = @cart.status ? nil : 'checked'
        @cart.save
        # render plain:@cart.status ? 'isi' : 'kosong'
    end

    def destroy
        @cart = Cart.find(params[:id])
        @destroy = @cart.destroy
        
        # render plain:@destroy
        redirect_to root_path, status: :see_other
    end

    private

    def resource_param
        params. permit(:user_id, :product_id, :vendor_id)
    end

end