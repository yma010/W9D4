class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?
  
  def current_user
    return nil unless session[:session_token]
    User.find_by(session_token: session[:session_token])
  end
  
  def logged_in?
    !!current_user
  end

  def ensure_user_login
    unless logged_in?
      flash[:errors] = "Must be logged in"
      redirect_to new_session_url
    end
  end

  def current_user?
    if current_user.nil?
      redirect_to new_session_url
    end
  end
end
