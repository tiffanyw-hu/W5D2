class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def login(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end

  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url 
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:errors] = [ "Must be logged in" ]
      redirect_to new_session_url
    end
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

end
