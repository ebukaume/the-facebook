# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    fetch_resource(:post)
    flash[:post_notice] = @post.create_comment(current_user, comment_params)
    redirect_to root_path anchor: @post
  end

  def edit
    fetch_resource(:comment)
    @post = Post.new
    @posts = Post.all
    render 'home/index'
  end

  def update
    unless (resource = fetch_resource(:comment)).is_a? String
      flash[:post_notice] = resource.update_comment(current_user, comment_params)
    end
    redirect_to root_path anchor: @comment
  end

  def destroy
    unless (resource = fetch_resource(:comment)).is_a? String
      flash[:post_notice] = resource.delete_comment(current_user)
    end
    redirect_to root_path anchor: resource.post
  end

  private

  def comment_params
    return params.require(:comment).permit(:content) if flash[:action] == 'update'

    params.require(:comment).permit(:post_id, :content).merge(author_id: current_user.id)
  end

  def fetch_resource(kind)
    if kind == :post
      return @post if (@post = Post.find_by(id: params[:comment][:post_id]))
    elsif kind == :comment
      return @comment if (@comment = Comment.find_by(id: params[:id]))
    end

    'Oops! the post you wish to interact with has been removed or never existed!'
  end
end
