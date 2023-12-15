class Api::V1::CommentsController < ApplicationController
  before_action :set_user_and_post, only: %i[new create]
  before_action :set_api_user, only: %i[create]
  load_and_authorize_resource

  def index
    @comments = Comment.where(post_id: params[:post_id], author_id: params[:user_id])
    render json: @comments
  end

  def create
    @comment = if @api_user
                 @post.comments.build(comment_params.merge(author_id: @api_user.id))
               else
                 @post.comments.build(comment_params.merge(author_id: current_user.id))
               end

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_user_and_post
    @user = User.includes(posts: :comments).find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:post_id])
  end
end
