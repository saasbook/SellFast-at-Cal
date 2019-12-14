class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate!
	
	protected
	
	def authenticate!
		authenticate_user!
	end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :avatar])
  end

  def set_search
    @q=Item.search(params[:q])
  end
end
