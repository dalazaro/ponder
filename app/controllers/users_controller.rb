class UsersController < ApplicationController
  # get "/signup", to: "users#new", as: "new_user"
  def new
    @user = User.new
  end

  # post "/users", to: "users#create"
  def create
    user_params = params.require(:user).permit(:username, :password, :email)
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
    @posts = @posts.reverse
  end

  # get "/users/:id/edit", to: "users#edit", as: "edit_user"
  def edit
    if params[:id].to_i != session[:user_id]
      flash[:error] = "You are not authorized to edit this user's profile."
      redirect_to user_path params[:id]
    else
      @user = User.find_by_id(params[:id])
    end
  end

  # patch "/users/:id", to: "users#update"
  def update
    user_params = params.require(:user).permit(:first_name, :last_name, :bio, :email)
    if params[:id].to_i != session[:user_id]
      flash[:error] = "You are not authorized to edit this user's profile."
      redirect_to user_path params[:id]
    else
      user = User.find_by_id(params[:id])
      user.update_attributes(user_params)
      redirect_to user_path user
    end
  end

  # delete "/users/:id", to: "users#destroy", as: "delete_user"
  def destroy
    user = User.find_by_id(params[:id])
    user.destroy
    redirect_to new_user_path
  end
end
