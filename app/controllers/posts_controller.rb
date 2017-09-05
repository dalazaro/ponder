class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  # get "/posts/new", to: "posts#new"
  def new
    if session[:user_id] != nil
      @post = Post.new
    else
      flash[:error] = "Before you start pondering, please create an account or log in."
      redirect_to new_user_path
    end
  end

  # post "/posts", to: "posts#create"
  def create
    post_params = params.require(:post).permit(:title, :content)
    p "length is " + post_params[:content].length.to_s
    if session[:user_id] == nil
      flash[:error] = "Before you start pondering, please create an account or log in."
      redirect_to new_user_path
    elsif post_params[:content].length > 1000
      #TODO resolve, since this counts escaped chars (e.g. "\n") as 2
      flash[:error] = "Post cannot be longer than 1000 characters."
      redirect_to new_post_path
    else
      post = Post.new(post_params)
      post.user_id = session[:user_id]
      if post.save  #if save was successful, redirect
        redirect_to user_path(session[:user_id])
      end
    end
  end

  # get "/posts/:post_id", to: "posts#show"
  def show
    @post = Post.find_by_id(params[:post_id])
  end

  # get "/posts/:post_id/edit", to: "posts#edit"
  def edit
    @post = Post.find_by_id(params[:post_id])
    if @post.user_id != session[:user_id]
      flash[:error] = "You are not authorized to edit this post."
      redirect_to post_path(params[:post_id])
    end
  end

  # patch "/posts/:post_id", to: "posts#update"
  def update
    post_params = params.require(:post).permit(:title, :content)
    post = Post.find_by_id(params[:post_id])
    # user authorization
    if post.user_id != session[:user_id]
      flash[:error] = "You are not authorized to edit this post."
    else
      post.update_attributes(post_params)
    end
    redirect_to post_path post
  end

  # delete "/posts/:post_id", to: "posts#destroy"
  def destroy
    post = Post.find_by_id(params[:post_id])
    post.destroy # delete this post from db
    redirect_to user_path(session[:user_id])
  end
end
