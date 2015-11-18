class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def welcome
    render '/welcome'
  end

  def results
    render '/results'
  end

  def sign_up
    render '/sign_up'
  end

  def log_in
    render '/log_in'
  end

  private

  def current_user
    @current_user ||= session[:current_user_id] &&
    User.find(session[:current_user_id])
  end

  def logged_in?
    !!current_user
  end

  def require_current_user
  redirect_to root_path unless logged_in?
  end

end
