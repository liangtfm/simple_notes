class PostsController < ApplicationController
  before_filter :require_signed_in!, :except => [:show]

  def index
    @posts = current_user.posts

    if request.xhr?
      render json: @posts
    else
      render :index
    end
  end

  def create
    @post = current_user.posts.new(params[:post])

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

  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      render json: @post
    else
      render json: @post.errors, status: 422
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    if request.xhr?
      render :index
    end
  end
end
