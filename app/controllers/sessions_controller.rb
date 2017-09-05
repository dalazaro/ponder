class SessionsController < ApplicationController
  # get "/login", to: "sessions#new"
  def new
    @user = User.new
  end

  # post "/sessions", to: "sessions#create"
  def create
    @user = User.confirm(user_params)
    if @user
      login(@user)
      flash[:notice] = "Successfully Logged In!"
      redirect_to user_path(@user)
    else
      flash[:error] = "Incorrect email or password"
      redirect_to login_path
    end
  end

  # get "/logout", to: "sessions#destroy"
  def destroy
    logout
    flash[:notice]="Successfully Logged Out."
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
