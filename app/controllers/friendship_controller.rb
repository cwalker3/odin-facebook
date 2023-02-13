class FriendshipController < ApplicationController
  def create
    @friendship = Friendship.new(friendship_params)
    @reverse_friendship = Friendship.new(reverse_friendship_params)

    if @friendship.save && @reverse_friendship.save
      redirect_back fallback_location: root_path, notice: 'Friend request accepted'
      FriendRequest.destroy_by(friend_request_params)
    else
      redirect_back fallback_location: root_path, notice: 'Failed'
    end
  end

  private

  def friendship_params
    params.permit(:user_id, :friend_id)
  end

  def reverse_friendship_params
    {user_id: friendship_params[:friend_id], friend_id: friendship_params[:user_id]}
  end

  def friend_request_params
    {user_id: friendship_params[:user_id], requestor_id: friendship_params[:friend_id]}
  end
end
