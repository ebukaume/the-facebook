class PostsController < ApplicationController
  before_action :verify_authorship, only: [:edit, :update, :destroy]
  before_action :fetch_posts, only: [:create, :edit, :update, :destroy]

  def create
    create_post post_params
  end

  def edit
    render 'home/index'
  end

  def update
    update_post post_params
  end

  def destroy
    destroy_post
  end

  private

  def create_post(post_params)
    @post = current_user.create_post(post_params)
    if @post.errors.none?
      flash[:post_success] = "Post successfuly created!" 
      @post = Post.new
      redirect_to root_path
    else
      render 'home/index'
    end
  end

  def update_post(post_params)
    if @post.update_attributes(post_params)
      flash[:post_success] = "Post successfuly edited!" 
      @post = Post.new
    else
      flash[:danger] = "Oops! Please make sure the content is at least 2 character long!" 
    end
    redirect_to root_path
  end

  def destroy_post
    if @post.destroy 
      flash[:post_success] = "Post successfuly deleted!"
      redirect_to root_path
    end
  end

  def verify_authorship
    unless @post = Post.find_by(id: params[:id])
      flash[:notice] = "Oops! the post you wish to interact with has been removed or never existed!"
      redirect_to root_path
    end

    unless post_authored_by_current_user
      flash[:danger] = "Sorry, but you are not the author of this post!"
      redirect_to root_path
    end
  end

  def fetch_posts
    @posts = Post.visible_to_user
  end

  def post_authored_by_current_user
    @post.author == current_user
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
