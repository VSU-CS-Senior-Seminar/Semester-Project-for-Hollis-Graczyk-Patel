class RegistrationsController < Devise::RegistrationsController
  layout "profile"
  prepend_before_action :require_no_authentication, only: [:cancel]
  prepend_before_action :authenticate_scope!, only: []
  before_action :moderator_only, only: [:new]
  
  
  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :name, :address)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :points, :name, :address)
  end
  
  def sign_up(resource_name, resource)

  end
  
  def moderator_only
    if current_user.role != "Lead" 
      if current_user.role != "Admin"
        flash[:notice] = "You are not authorized to view this page"
        redirect_to home_path
      end
    end
  end
  
end