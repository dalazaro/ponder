class PostsController < ApplicationController
  def index
    @posts = Post.all
  end
  # get "/users/:user_id/posts/new", to: "posts#new"
  def new
    @post = Post.new
  end
  # post "/users/:user_id/posts", to: "posts#create"
  def create
    post_params = params.require(:post).permit(:title, :content)
    p "length is " + post_params[:content].length.to_s
    if post_params[:content].length > 1000
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
  # get "/users/:user_id/posts/:post_id", to: "posts#show"
  def show
    @post = Post.find_by_id(params[:post_id])
  end
  # get "/users/:user_id/posts/:post_id/edit", to: "posts#edit"
  def edit
    @post = Post.find_by_id(params[:post_id])
  end
  # patch "/users/:user_id/posts/:post_id", to: "posts#update"
  def update
    post_params = params.require(:post).permit(:title, :content)
    post = Post.find_by_id(params[:post_id])
    # TODO error handling!
    post.update_attributes(post_params)
    redirect_to post_path post
  end
  # delete "/users/:user_id/posts/:post_id", to: "posts#destroy"
  def destroy
    post = Post.find_by_id(params[:post_id])
    post.destroy # delete this post from db
    redirect_to user_path(session[:user_id])
  end
end
