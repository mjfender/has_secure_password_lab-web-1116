require 'pry'
class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def index
    authenticate_user
    #check for logged-in state 
      # redirect to login if not
      # render index.html.erb if so (default)
  end

  def create
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to home_path
    else
      flash[:notice] = 'Username or password was incorrect'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged out!'
    redirect_to login_path
  end

end
