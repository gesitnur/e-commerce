class CartsController < ApplicationController
  
    def index
        @cart = current_user.carts
        # render plain:current_user.carts.inspect
    end

    def create

        @old_cart = Cart.where(user_id: current_user.id, product_id: resource_param[:product_id]).first

        if @old_cart
            @old_cart.update(qty: @old_cart.qty + 1, total: @old_cart.total * 2)
        else
            @cart = Cart.new(resource_param)
            @cart.qty = 1
    
            # render plain:@cart.inspect
    
            @cart.save
        end

        
        redirect_to root_path
        flash.alert = "Berhasil Disimpan"
        
        


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
        params. permit(:user_id, :product_id, :vendor_id, :total)
    end

end