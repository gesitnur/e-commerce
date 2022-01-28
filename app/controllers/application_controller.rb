class ApplicationController < ActionController::Base

    def after_sign_in_path_for(resource)
        if current_user.role == 1
            new_user_registration_path
        elsif current_user.role == 2
            root_path
        elsif current_user.role == 3
            new_user_session_path
        end
      end
end
