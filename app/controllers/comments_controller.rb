class CommentsController < ApplicationController
  before_action :set_user_and_post, only: %i[new create]
  before_action :set_api_user, only: %i[create]
  load_and_authorize_resource

  def index
    @comments = Comment.where(post_id: params[:post_id], author_id: params[:user_id])
    respond_to do |format|
      format.json { render json: @comments }
      format.html do
        flash[:error] = 'Comments index is available only in API requests'
        redirect_to root_path
      end
    end
  end

  def new
    store_referer
    @comment = Comment.new
  end

  def create
    if @api_user
      @comment = @post.comments.build(comment_params.merge(author_id: @api_user.id))
      if @comment.save
        render json: @comment, status: :created
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    else

      @comment = @post.comments.build(comment_params.merge(author_id: current_user.id))

      if @comment.save
        flash[:success] = 'Comment saved successfully'
        redirect_back_or_default(user_post_path(@user, @post))
      else
        flash.now[:error] = 'Error: Comment could not be saved'
        render :new
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      flash[:success] = 'Comment deleted successfully'
    else
      flash[:error] = 'Error: Comment could not be deleted'
    end

    redirect_back_or_default(root_path)
  end

  private

  def set_api_user
    return if request.headers['Authorization'].nil?

    token = request.headers['Authorization'].split.last
    @api_user = User.find_by(token:)
    p 'token: ', token, 'api_user: ', @api_user
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def set_user_and_post
    @user = User.includes(posts: :comments).find(params[:user_id])
    @post = @user.posts.includes(:comments).find(params[:post_id])
  end

  def store_referer
    session[:referer] = request.referer
  end

  def redirect_back_or_default(default)
    redirect_to(session[:referer] || default)
    session.delete(:referer)
  end
end
