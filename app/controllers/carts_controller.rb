class CartsController < ApplicationController
  
    def index
        @cart = current_user.carts
        # render plain:current_user.carts.inspect
    end

    def create

        @cart = Cart.new(resource_param)
        @cart.qty = 1

        # render plain:@cart.inspect

        if @cart.save
            redirect_to root_path
            flash.alert = "Berhasil Disimpan"
        else
            render 'show'
        end
        # render plain: resource_param


    end

    def update
        # render plain:
        @cart = Cart.find(params[:id])
        @cart.status = @cart.status ? nil : 'checked'
        @cart.save
        # render plain:@cart.status ? 'isi' : 'kosong'
    end

    private

    def resource_param
        params. permit(:user_id, :product_id, :vendor_id, :total)
    end

end