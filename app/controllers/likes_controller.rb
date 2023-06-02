class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)

    if @like.save
      redirect_back fallback_location: root_path, notice: 'Liked post'
    else
      redirect_back fallback_location: root_path, notice: 'Failed to like post'
    end
  end

  private

  def like_params
    params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
  end
end
