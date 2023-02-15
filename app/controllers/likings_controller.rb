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
    params.require(:liking).permit(:user_id, :likeable_id, :likeable_type)
  end
end
