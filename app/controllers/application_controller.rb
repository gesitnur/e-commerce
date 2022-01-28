class ApplicationController < ActionController::Base

    def after_sign_in_path_for(resource)
        if current_user.has_role? :customer
            root_path
        elsif current_user.has_role? :vendor
            transaction_orders_path
        elsif current_user.has_role? :admin
            orders_path
        else
            root_path
        end
    end
end
