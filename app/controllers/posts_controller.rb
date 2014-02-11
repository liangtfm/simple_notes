class PostsController < ApplicationController
  def index
    @posts = Post.all

    if request.xhr?
      render json: @posts
    else
      render :index
    end
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      render json: @post
    else
      render json: @post.errors, status: 422
    end
  end

  def show
    @post = Post.find(params[:id])
    render json: @post
  end
end
