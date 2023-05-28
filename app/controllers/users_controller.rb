class UsersController < ApplicationController

  def index
    @users = User.all
    @requestees = current_user.requestees.to_a
    @friends = current_user.friends
  end

  def show
    @user = User.find(params[:id])
  end
end
