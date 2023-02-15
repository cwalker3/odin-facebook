class LikingsController < ApplicationController
  def create
    @liking = Liking.new(liking_params)

    if @liking.save
      redirect_back fallback_location: root_path, notice: 'Liked post'
    else
      redirect_back fallback_location: root_path, notice: 'Failed to like post'
    end
  end

  private

  def liking_params
    params.permit(:liking).require(:user_id, :liked_id, :kind)
  end
end
