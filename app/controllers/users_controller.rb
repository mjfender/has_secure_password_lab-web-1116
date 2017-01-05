require 'pry'
class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    if User.find_by(name: params[:user][:name])
      flash[:notice] = 'That username is taken. Try another.'
      render :new
    elsif params[:user][:password] != params[:user][:password_confirmation]
      flash[:notice] = 'Your passwords do not match. Try again'
      @user = User.new(name: params[:user][:name])
      redirect_to users_new_path
    else
      @user = User.create(name: params[:user][:name], password: params[:user][:password])
      flash[:notice] = 'Welcome! You are now registered and logged in.'
      session[:user_id] = @user.id
      redirect_to home_path
    end

  end


end