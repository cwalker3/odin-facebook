class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all.includes(:friends, :friend_requests)
  end

  def show
    @user = User.find(params[:id])
  end
end
