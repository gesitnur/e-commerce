class AddressesController < ApplicationController
    
    def index
        # @user = current_user
        # render plain:current_user.inspect
    end

    def edit
        @address = Address.find(params[:id])
        
    end

    def update
        @address    = Address.find(params[:id])
        @address.update(resource_params)
        redirect_to profile_path
    end

    def new
        @address =  Address.new
    end

    def create
        @address        = Address.new(resource_params) 
        @address.user   = current_user

        # current_user.addresses.new

        # render plain:@address.inspect
        if @address.save
            redirect_to profile_path
        else
            flash[:notice] = @address.errors.full_messages
            redirect_to profile_path
        end
    end

    def destroy
        @address = Address.find(params[:id])

        
        if @address.destroy
            redirect_to profile_path, status: :see_other
        else
            flash[:notice] = @address.errors.full_messages
            redirect_to profile_path, status: :see_other
        end

    end

    private
    def resource_params
        params.require(:address). permit(:address)
    end

end