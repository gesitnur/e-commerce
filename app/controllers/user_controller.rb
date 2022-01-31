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
        render plain:params
    end        

    def destroy
        render plain:'ini delete'
    end
    
end