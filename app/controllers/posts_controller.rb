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
    post = Post.new(params.require(:post).permit(:title, :content))
    post.user_id = params[:user_id]
    post.save
    redirect_to posts_path
  end
  # get "/users/:user_id/posts/:post_id", to: "posts#show"
  def show
    p "in the show controller, user id: " + params[:user_id]
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
    post.update_attributes(post_params)
    redirect_to post_path post
  end
  # delete "/users/:user_id/posts/:post_id", to: "posts#destroy"
  def destroy
    p "user id:" + params[:user_id]
    p "post_id:" + params[:post_id]
    post = Post.find_by_id(params[:post_id])
    post.destroy # gone
    redirect_to user_path(params[:user_id])
  end

end
