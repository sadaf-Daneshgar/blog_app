class Api::V1::PostsController < ApplicationController
  before_action :set_user
  load_and_authorize_resource

  def index
    @posts = @user.posts.includes(:comments)
    render json: @posts
  end

  def create
    @post = @user.posts.build(post_params)

    if @post.save
      render json: @post, status: :created
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
