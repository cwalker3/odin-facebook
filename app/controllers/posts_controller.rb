class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @post = Post.new
    @comment = Comment.new
    @like = Like.new

    @posts = Post.from_user_and_friends(current_user)
                 .includes(:likes, :liked_by_user, { image_attachment: :blob }, { user: { profile: { avatar_attachment: :blob }}}, { comments: [:user, :likes, :liked_by_user] } )
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
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      redirect_back fallback_location: root_path, notice: 'Deleted'
    else
      redirect_back fallback_location: root_path, notice: 'Failed to Delete'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: 'Successfully updated post'
    else
      render :edit, status: :unprocessable_entity, notice: 'Failed to update post'
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :body, :image)
  end
end
