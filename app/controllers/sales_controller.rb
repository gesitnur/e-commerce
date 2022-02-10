class SalesController < ApplicationController
    
    before_action :authenticate_user!
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
            
            # User.restore_balance(User::find(@order.user_id), @order.total)

            # Product.restore_stock(@order.order_items)

            # t.product.update_product_and_stock({inventory_attributes: { stock: t.product.inventory.stock - t.qty}}, 'Penjualan')

        else
            # Product.custom_counter(@order.order_items)
        end

        # balance = current_user.balance.balance

        # current_user.balance.update(balance: balance + @order.total);

        @order.update(status: params[:status])
       
        # flash[:notice] = "Data Berhasil Diubah"
        redirect_to sales_path
    end

end