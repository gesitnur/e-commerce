class OrdersController < ApplicationController
    def index
        @order = current_user.carts.where(status: 'checked')

        @address = current_user.carts.find_by_user_id(current_user.id).user.addresses
        # render plain:@address.inspect

        # render plain:@coba.inspect
    end

    def create
        @item = current_user.carts.where(status: 'checked')

        no = 0

        ttl = 0

        coba =  []

        cb = []
        
        @arrayy = @item.group_by(&:vendor_id)

        @arrayy.each do |client_id, projects|
            @order        = Order.new(user_id:current_user.id , total: params[:total] , address_id: params[:address], vendor_id: client_id)
            @order.save
            projects.each do |t|
                coba[no] = {
                            order_id: @order.id, 
                            product_id: t.product_id,
                            qty: t.qty,
                            total: t.total
            
                        }
                    no += 1
                    t.product.add_stock(t.product, t.qty)
                    ttl = ttl+t.total
            end
            @order        = @order.update(total: ttl)
            ttl = 0
        end

        OrderItem.insert_all(coba) 
        
        User.update_balance(current_user, params[:total])

        # render plain:coba


        @item.destroy_all

        redirect_to root_path
        
    end

    def show
        @order = Order.find(params[:id])

        @order_item = @order.order_items

        # render plain:@order_item.inspect
    end

    def transaction
        if current_user.has_role? :customer
            @transaction = Order.where(user_id: current_user)
        elsif current_user.has_role? :vendor
            @transaction = Order.where(vendor_id: current_user)
        end

       
        # render plain:@transaction.inspect
    end

    def update
        @order = Order.find(params[:id])

        if params[:status] == '3'
            
            User.restore_balance(User::find(@order.user_id), @order.total)

            Product.restore_stock(@order.order_items)
        end
        @order.update(status: params[:status])
       
        redirect_to transaction_orders_path
    end

end