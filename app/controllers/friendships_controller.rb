class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(friendship_params)

    if @friendship.save
      redirect_back fallback_location: root_path, notice: 'You are now friends.'
      FriendRequest.destroy_by(friend_request_params)
    else
      redirect_back fallback_location: root_path, notice: 'Failed to become friends.'
    end
  end

  def index
    @friends = current_user.friends
  end

  private

  def friendship_params
    params.permit(:friend1_id, :friend2_id)
  end

  def friend_request_params
    { requestee_id: params[:friend1_id], requestor_id: params[:friend2_id] }
  end
end
