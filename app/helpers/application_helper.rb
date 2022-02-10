module ApplicationHelper
    def resource_name
      :user
    end
  
    def resource
      @resource ||= User.new
    end
  
    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end

    def list_role
        Role.where.not(name: 'admin').order('id')
    end
    
  end