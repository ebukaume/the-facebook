# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    fetch_resource(:post)
    flash[:post_notice] = @post.create_comment(current_user, comment_params)
    redirect_to back_with_anchor anchor: @post.id
  end

  def edit
    fetch_resource(:comment)
    @post = Post.new
    @posts = Post.all
    save_referrer
    render 'home/index'
  end

  def update
    if (resource = fetch_resource(:comment)).is_a? String
      flash[:post_notice] = resource
      redirect_back(fallback_location: root_path) && return
    end
    flash[:post_notice] = resource.update_comment(current_user, comment_params)
    @comment = Comment.new
    redirect_to back_with_anchor anchor: resource.id
  end

  def destroy
    if (resource = fetch_resource(:comment)).is_a? String
      flash[:post_notice] = resource
      redirect_back(fallback_location: root_path) && return
    end
    flash[:post_notice] = resource.delete_comment(current_user)
    redirect_to back_with_anchor anchor: resource.post.id
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
