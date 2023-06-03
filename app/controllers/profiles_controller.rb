class ProfilesController < ApplicationController
  def show
    @profile = Profile.find(params[:id])
    @posts = @profile.user.posts
    @comment = Comment.new
    @like = Like.new
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])

    if @profile.update(profile_params)
      redirect_back fallback_location: root_path, notice: 'Updated profile'
    else
      redirect_back fallback_location: root_path, notice: 'Failed to update profile'
    end
  end

  def index
    @profiles = Profile.all.includes(:user, { avatar_attachment: :blob })
    @requestees = current_user.requestees.to_a
    @friends = current_user.friends
  end

  private

  def profile_params
    params.require(:profile).permit(:avatar, :first_name, :last_name, :location, :gender)
  end
end
