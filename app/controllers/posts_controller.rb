# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :fetch_post, only: %i[edit update destroy]
  before_action :fetch_posts, only: %i[create edit]

  def create
    create_post post_params
  end

  def edit
    @comment = Comment.new
    render 'home/index'
  end

  def update
    flash[:post_notice] = @post.update_post(current_user, post_params)
    redirect_to root_path anchor: @post
  end

  def destroy
    flash[:post_notice] = @post.delete_post(current_user)
    redirect_to root_path
  end

  private

  def create_post(post_params)
    @post = current_user.create_post(post_params)
    if @post.errors.none?
      flash[:post_notice] = 'Post successfuly created!'
      @post = Post.new
      redirect_to root_path
    else
      render 'home/index'
    end
  end

  def fetch_post
    return if (@post = Post.find_by(id: params[:id]))

    flash[:post_notice] = 'Oops! the post you wish to interact with has been removed or never existed!'
    redirect_to root_path
  end

  def fetch_posts
    @posts = Post.visible_to_user
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
