class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @post = Post.new
    @posts = Post.posts_from(User.user_and_friends_ids(current_user))
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_back fallback_location: root_path, notice: 'Posted'
    else
      redirect_back fallback_location: root_path, notice: 'Failed to post'
    end
  end

  def show

  end

  private

  def post_params
    params.require(:post).permit(:user_id, :body)
  end
end
