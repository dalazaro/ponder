class UsersController < ApplicationController
  # get "/signup", to: "users#new", as: "new_user"
  def new
    @user = User.new
  end

  # post "/users", to: "users#create"
  def create
    user_params = params.require(:user).permit(:username, :email, :password, :password_confirmation)
    if (User.find_by username: user_params[:username]) #check for pre-existing username
      flash[:error] = "A user with the username \"#{user_params[:username]}\" already exists."
      redirect_to new_user_path
    elsif (User.find_by email: user_params[:email]) #check for pre-existing e-mail
      flash[:error] = "A user with the e-mail address \"#{user_params[:email]}\" already exists."
      redirect_to new_user_path
    elsif user_params[:email] !~ /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/ #validate e-mail
      flash[:error] = "\"#{user_params[:email]}\" is not a valid e-mail address."
      redirect_to new_user_path
    elsif user_params[:password].length < 8
      flash[:error] = "Password must be at least 8 characters long."
      redirect_to new_user_path
    elsif user_params[:password] != user_params[:password_confirmation]
      flash[:error] = "Passwords did not match."
      redirect_to new_user_path
    else
      @user = User.create(user_params)
      login(@user)
      redirect_to user_path(@user.username)
    end
  end

  # get "/users/:username", to: "users#show", as: "user"
  def show
    @user = User.find_by username: params[:username]
    @posts = Post.where user_id: @user.id
    @posts = @posts.reverse
  end

  # get "/users/:username/edit", to: "users#edit", as: "edit_user"
  def edit
    user = User.find_by username: params[:username]
    if !user || user.id != session[:user_id]
      flash[:error] = "You are not authorized to edit this user's profile."
      redirect_to user_path params[:username]
    else
      @user = User.find_by username: params[:username]
    end
  end

  # patch "/users/:username", to: "users#update"
  def update
    user_params = params.require(:user).permit(:first_name, :last_name, :bio, :email, :image)
    user = User.find_by username: params[:username]
    if !user || user.id != session[:user_id]
      flash[:error] = "You are not authorized to edit this user's profile."
      redirect_to user_path params[:username]
    else
      user.update_attributes(user_params)
      redirect_to user_path(user.username)
    end
  end

  # delete "/users/:username", to: "users#destroy", as: "delete_user"
  def destroy
    user = User.find_by username: params[:username]
    if !user || user.id != session[:user_id]
      flash[:error] = "You are not authorized to delete this user."
      redirect_to user_path(params[:username])
    else
      user.destroy
      redirect_to new_user_path
    end
  end
end
