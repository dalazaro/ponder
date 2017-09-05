class UsersController < ApplicationController
  # get "/signup", to: "users#new", as: "new_user"
  def new
    @user = User.new
  end

  # post "/users", to: "users#create"
  def create
    user_params = params.require(:user).permit(:username, :password, :email)
    prev_username = User.find_by username: user_params[:username]
    prev_email = User.find_by email: user_params[:email]
    if prev_username
      flash[:error] = "A user with the username \"#{user_params[:username]}\" already exists."
      redirect_to new_user_path
    elsif prev_email
      flash[:error] = "A user with the e-mail address \"#{user_params[:email]}\" already exists."
      redirect_to new_user_path
    else
      @user = User.create(user_params)
      login(@user)
      redirect_to user_path(@user)
    end
  end

  # get "/users/:id", to: "users#show", as: "user"
  def show
    @user = User.find_by_id(params[:id])
    @posts = Post.where user_id: params[:id]
  end

  # get "/users/:id/edit", to: "users#edit", as: "edit_user"
  def edit
    @user = User.find_by_id(params[:id])
  end

  # patch "/users/:id", to: "users#update"
  def update
    user_params = params.require(:user).permit(:first_name, :last_name, :bio, :email)
    user = User.find_by_id(params[:id])
    user.update_attributes(user_params)
    redirect_to user_path user
  end

  # delete "/users/:id", to: "users#destroy", as: "delete_user"
  def destroy
    user = User.find_by_id(params[:id])
    user.destroy # gone
    redirect_to new_user_path
  end
end
