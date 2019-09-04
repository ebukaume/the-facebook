class PostsController < ApplicationController
  before_action :fetch_post, only: [:edit, :update, :destroy]
  before_action :fetch_posts, only: :edit
  after_action :fetch_posts, only: [:create, :update, :destroy]

  def create
    create_post post_params
    render 'home/index'
  end

  def edit
    render 'home/index'
  end

  def update
    update_post post_params
    redirect_to root_path
  end

  def destroy
  end

  private

  def create_post(post_params)
    @post = current_user.create_post(post_params)
    if @post.errors.none?
      flash.now[:post_success] = "Post successfuly created!" 
      @post = Post.new
    end
  end

  def update_post(post_params)
    if @post.update(post_params)
      flash.now[:post_success] = "Post successfuly edited!" 
      @post = Post.new
    end
  end

  def fetch_post
    @post = Post.find(params[:id])
  end

  def fetch_posts
    @posts = Post.recent
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
