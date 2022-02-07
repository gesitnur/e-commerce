class UserController < ApplicationController
    def index
        @user = User::all
        # render plain:@user
    end

    def show
        @user = User::find(params[:id])
        @address  = @user.addresses
        # render plain: @address.inspect
    end

    def edit
        @user = User::find(params[:id])
        @balance  = @user.balance
        @role  = @user.roles.pluck(:name)[0]
        # render plain: @role.inspect

    end

    def update
        @user = User::find(params[:id])
        
        @user.update(resource_params)

        if params[:role] != @user.roles[0].name
            @user.remove_role(@user.roles[0].name)

            @user.grant(params[:role] )
        end
        
        # @user.remove_role(:admin)

        # @user.grant(:customer)
        
        render plain:resource_params[:role] != @user.roles[0].name
        # render plain:@user.roles[0].name
    end        

    def destroy
        render plain:'ini delete'
    end

    def topup
        @user    = User.find(params[:id])
        @user.balance.update(balance: params[:topup].to_i + @user.balance.balance) 
    end

    private

    def resource_params
        params.require(:user). permit(:name, :email, :phone, :city)
    end
    
end