class Api::V1::PostsController < ApplicationController

  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json: post, location: [:api, post]
    else
      render json: { errors: post.errors }
    end
  end

end
