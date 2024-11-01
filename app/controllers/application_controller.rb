class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
  
  def after_sign_in_path_for(resource)
    # Rediriger vers la page des items de l'utilisateur après la connexion
    user_items_path(resource)
  end
end
