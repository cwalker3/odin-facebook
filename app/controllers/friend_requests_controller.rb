class FriendRequestsController < ApplicationController
  def create
    @friend_request = FriendRequest.new(friend_request_params)

    if @friend_request.save
      redirect_back fallback_location: root_path, notice: 'Friend request sent.'
    else
      redirect_back fallback_location: root_path, notice: 'Failed to send friend request.'
    end
  end

  def index
    @requestors = current_user.requestors
  end

  private

  def friend_request_params
    params.permit(:requestor_id, :requestee_id)
  end
end
