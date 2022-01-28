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

        coba =  []
        
        @arrayy = @item.group_by(&:vendor_id)

        @arrayy.each do |client_id, projects|
            @order        = Order.new(user_id:current_user.id , total: params[:total] , address_id: params[:address], vendor_id: client_id)
            # @order.save
            projects.each do |t|
                coba[no] = {
                            order_id: @order.id, 
                            product_id: t.product.stock(t.product, t.qty),
                            qty: t.qty,
                            total: t.total
            
                        }
                    no += 1
            end
            # coba = []
            
        end

        # OrderItem.insert_all(coba) 
        
        # User.update_balance(current_user, params[:total])

        render plain:coba

        # render plain:@item.inspect

        # title       = params[:book][:title]
        # description = params[:book][:description]
        # page        = params[:book][:page]
        # price       = params[:book][:price]
        # book        = Book.new(title: title, description: description, 
        #                 page: page, price: price)
        
        # @order        = Order.new(user_id:current_user.id , total: params[:total] , address_id: params[:address])
        # @order.save
        # # p = Product.new
        # @item.each do |t|
            
        #     coba[no] = {
        #         order_id: @order.id, 
        #         product_id: t.product.user_id,
        #         qty: t.qty,
        #         total: t.total

        #     }
        #     no += 1
        # end

        
        # OrderItem.insert_all(coba) 
        # user.update_balance(current_user, params[:total])
        # @item.save

        # render plain:coba

        # @item.destroy_all

        # redirect_to root_path

        # render plain:@item.inspect
        
        # render plain:params
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
        @order.update(status: params[:status])

        redirect_to transaction_orders_path
    end

end