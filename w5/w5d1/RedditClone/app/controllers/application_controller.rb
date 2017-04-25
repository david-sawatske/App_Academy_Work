class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  helper_method :logged_in?
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    user.update_token!
    session[:session_token] = user.session_token
  end

  def log_out!
    @current_user.update_token!
    session[:session_token] = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def redirect_if_not_logged_in
    redirect_to new_session_url unless logged_out?
  end
end
