# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    
    @user = User.new

    @user.build_users_role

  end

  # POST /resource
  def create
    # # render plain:params[:user][:user_role]
    # @user = User.create(resource_params)
    # @user.grant(params[:user][:user_role][:role_id] )

    # @user = build_resource(resource_params)
    # @user.grant(params[:user][:user_role][:role_id] )
    # render plain:@user
    
    # render plain:params

    build_resource(resource_params)
    resource.save

    # resource.grant(params[:user][:user_role][:role_id] )
    resource.create_balance(balance: 0 )

    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)


        if current_user.has_role? :customer
            root_path
        elsif current_user.has_role? :vendor
            transaction_orders_path
        else
            root_path
        end


        redirect_to root_path
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end

  end

  # def create
  #   super
  # end
   

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private
  def resource_params
    params.require(:user).permit(:email, :name, :phone, :password, :role_id, users_role_attributes: [:role_id])

end

end
