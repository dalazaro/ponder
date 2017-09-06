class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  # get "/posts/new", to: "posts#new"
  def new
    if session[:user_id]
      @post = Post.new
      @post_length = 0
    else
      flash[:error] = "Before you start pondering, please create an account or log in."
      redirect_to new_user_path
    end
  end

  # post "/posts", to: "posts#create"
  def create
    post_params = params.require(:post).permit(:title, :content)
    user_id = session[:user_id]
    if true_length(post_params[:content]) > 1000
      flash[:error] = "Your post is over the limit."
      redirect_to new_post_path
    elsif user_id == nil
      flash[:error] = "Before you start pondering, please create an account or log in."
      redirect_to new_user_path
    elsif post_params[:title].length < 1
      flash[:error] = "Post must have a title."
      redirect_to new_post_path
    else
      post = Post.new(post_params)
      post.user_id = user_id
      user = User.find_by_id user_id
      if post.save  #if save was successful, redirect
        redirect_to user_path user.username
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
    @post_length = true_length(@post.content)
    if @post.user_id != session[:user_id]
      flash[:error] = "You are not authorized to edit this post."
      redirect_to post_path(params[:post_id])
    end
  end

  # patch "/posts/:post_id", to: "posts#update"
  def update
    post_params = params.require(:post).permit(:title, :content)
    if true_length(post_params[:content]) > 1000
      flash[:error] = "This post is beyond the length limit."
      redirect_to edit_post_path params[:post_id]
    else
      post = Post.find_by_id(params[:post_id])
      # user authorization
      if post.user_id != session[:user_id]
        flash[:error] = "You are not authorized to edit this post."
      else
        post.update_attributes(post_params)
      end
      redirect_to post_path post
    end
  end

  # delete "/posts/:post_id", to: "posts#destroy"
  def destroy
    post = Post.find_by_id(params[:post_id])
    if post.user_id != session[:user_id]
      flash[:error] = "You are not authorized to delete this post."
    else
      user = User.find_by_id post.user_id
      post.destroy # delete this post from db
      redirect_to user_path(user.username)
    end
  end

  private

  def true_length(str)
    str = str.gsub("\r\n", 'x')
    str.length
  end
end
