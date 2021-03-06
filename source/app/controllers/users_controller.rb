require "byebug"

class UsersController < ApplicationController
  def show
    @user = User.find(session[:user_id]) if session[:user_id]
    if @user.nil?
      flash[:not_logged_in_error] = 'You cannot access this page, because you are not logged in.'
      redirect_to '/'
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      flash[:signup_error] = 'An error occurred while signing up.'
      redirect_to '/signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
