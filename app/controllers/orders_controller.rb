class OrdersController < ApplicationController
    
    before_action :authenticate_user!

    before_action :find_cart, only: [:index, :create]
    
    def index
        @address = current_user.addresses
        # render plain:@address.inspect
    end

    def create
        no = 0

        total = 0

        item =  []
        
        @arrayy = @order.group_by(&:vendor_id)

        @arrayy.each do |client_id, projects|
            @order        = Order.new(user_id:current_user.id , total: params[:total] , address_id: params[:address], vendor_id: client_id)
            @order.save
            projects.each do |t|
                item = {
                            order_id:   @order.id, 
                            product_id: t.product_id,
                            qty:        t.qty,
                            total:      t.product.price * t.qty
            
                        }

                        OrderItem.create(item) 
                    no += 1
                    # t.product.update_product_and_stock({inventory_attributes: { stock: t.product.inventory.stock - t.qty}}, 'Penjualan')

                    # t.product.add_stock(t.product, t.qty)
                    # t.product.custom_counter(t.product, t.qty)
                    total = total+t.product.price * t.qty
                    

            end
            @order        = @order.update(total: total)
            total = 0
        end

        
        User.update_balance(current_user, params[:total])

        @order.destroy_all

        redirect_to transaction_orders_path
        
    end

    def show
        @order = Order.find(params[:id])

        @order_item = @order.order_items

        # render plain:@order_item.inspect
    end

    def transaction
        @transaction = Order.where(user_id: current_user)
        # render plain:@transaction.inspect
    end

    private

    def find_cart
        @order = current_user.carts.where(status: 'checked')
    end

end