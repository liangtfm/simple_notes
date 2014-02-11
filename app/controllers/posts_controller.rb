class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(params[:post])

    if @post.save
      render json: @post
    else
      render json: @post.errors, status: 422
    end
  end
end
