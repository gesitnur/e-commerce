class SalesController < ApplicationController
    def index
        @transaction = Order.where(vendor_id: current_user.vendor)
    end

    def show
        @order = Order.find(params[:id])

        @order_item = @order.order_items
    end

    def update
        @order = Order.find(params[:id])
        if params[:status] == '3'
            
            User.restore_balance(User::find(@order.user_id), @order.total)

            Product.restore_stock(@order.order_items)
        else
            Product.custom_counter(@order.order_items)
        end
        # render plain: 'ini update di sales'
        @order.update(status: params[:status])
       
        flash[:notice] = "Data Berhasil Diubah"
        redirect_to sales_path
    end

end