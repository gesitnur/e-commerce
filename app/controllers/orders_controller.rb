class OrdersController < ApplicationController
    def index
        @order = current_user.carts.where(status: 'checked')

        @address = current_user.carts.find_by_user_id(current_user.id).user.addresses.first


        # render plain:@coba.inspect
    end

    def create
        @item = current_user.carts.where(status: 'checked')

        no = 0

        coba =  []
        
        @arrayy = @item.group_by(&:vendor_id)

        @arrayy.each do |client_id, projects|
            # @order        = Order.new(user_id:current_user.id , total: params[:total] , address_id: params[:address])
            # @order.save
            projects.each do |t|
                coba[no] = {
                            # order_id: @order.id, 
                            product_id: t.product.user_id,
                            qty: t.qty,
                            total: t.total
            
                        }
                    no += 1
            end
            # coba = []
            
        end


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
        
        user = User.new
        # user.update_balance(current_user, params[:total])
        # @item.save

        # render plain:coba

        # @item.destroy_all

        # redirect_to root_path

        # render plain:@item.inspect
        
        # render plain:params
    end

    def new
        render plain:"aa"
    end

    def transaction
        @transaction = Order.where(user_id: current_user)
        # render plain:@transaction.inspect
    end

end