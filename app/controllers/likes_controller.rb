class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @like = current_user.likes.build(like_params)
    if @like.save
      redirect_to @like, notice: 'Like was successfully created.'
    else
      render :new
    end
  end
end
