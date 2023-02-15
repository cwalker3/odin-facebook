class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, notice: 'Failed to comment'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :body)
  end
end
