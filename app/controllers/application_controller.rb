class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Configure what can be used for sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :password, :password_confirmation])

    # Configure what can be used for sign in
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password])

    # Configure what can be updated
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :bio, :password, :password_confirmation, :current_password])
  end
end
