class AddressesController < ApplicationController
    
    before_action :authenticate_user!
    before_action :find_address
    
    def index
        # @user = current_user
        # render plain:current_user.inspect
    end

    def edit ;end

    def update
        @address.update(resource_params)
        redirect_to profile_path
    end

    def new
        @address =  Address.new
    end

    def create
        if current_user.addresses.create(resource_params)
            redirect_to profile_path
        else
            flash[:notice] = @address.errors.full_messages
            redirect_to profile_path
        end
    end

    def destroy
        # if @address.destroy
        #     redirect_to profile_path, status: :see_other
        # else
        #     flash[:notice] = @address.errors.full_messages
        #     redirect_to profile_path, status: :see_other
        # end

        render plain:'ini hapus data'

    end

    private
    def resource_params
        params.require(:address). permit(:address)
    end

    def find_address
        @address    = Address.find(params[:id])
    end

end