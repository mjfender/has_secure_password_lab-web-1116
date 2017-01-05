class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?


  private

  def authenticate_user
    if !logged_in?
      flash[:notice] = 'You must be logged in to view this'
      redirect_to login_path
    end
  end

  def logged_in?
    !!session[:name]
  end

  def current_user
    @current_user ||= User.find(session[:name])
  end
end
