# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :fetch_post

  def create
    flash[:post_notice] = @post.create_comment(current_user, comment_params)
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:post_id, :content).merge(author_id: current_user.id)
  end

  def fetch_post
    return if (@post = Post.find_by(id: params[:comment][:post_id]))

    flash[:post_notice] = 'Oops! the post you wish to interact with has been removed or never existed!'
    redirect_to root_path
  end
end
