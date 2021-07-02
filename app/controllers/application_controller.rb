class ApplicationController < ActionController::Base

  helper_method :current_user

  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def current_user
  #   return @current_user if defined?(@current_user)
  #   @current_user = true # current_user_session && current_user_session.user
  # end

  protected

  def after_sign_in_path_for(users)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:username, :password, :remember_me) }
  end
end
