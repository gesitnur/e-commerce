class ApplicationController < ActionController::Base

    def after_sign_in_path_for(resource)
        if current_user.has_role? :customer
            root_path
        elsif current_user.has_role? :vendor
            transaction_orders_path
        elsif current_user.has_role? :admin
            user_index_path
        else
            root_path
        end
    end

    # def after_sign_out_path_for(resource_or_scope)
    #     home_index_path
    # end
    
    
    # def after_sign_out_path_for(resource_or_scope)
    #     home_index_path
    #     # '/users/sign_in'
    #     # redirect_to :controller => "home", :action => "index", '_method' =>:get
    # end

    def error_404
        raise ActionController::RoutingError.new(params[:path])
    end

    # Handling no route match
    # rescue_from ActionController::RoutingError do |exception|
    #     logger.error "Routing error occurred"
    #         debugger
    #         respond_to do |format|
    #         # format.html {redirect_to previous_url, alert: "Page not found 404"}
    #         format.html {redirect_to root_path}
    #         format.any  {render json: {message: "not found 404", RCD: "00021"}, status: 404}
    #         end
    #     end

end
