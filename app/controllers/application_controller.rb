class ApplicationController < ActionController::Base

  helper_method :current_user

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = true # current_user_session && current_user_session.user
  end
end
