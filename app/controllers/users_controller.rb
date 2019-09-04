class UsersController < ApplicationController
  before_action :fetch_user, :fetch_posts_for_user_show, only: [:show]
  before_action :fetch_users, only: :index

  def index

  end

  def show
  end

  private

  def fetch_user
    unless @user = User.find_by(id: params[:id])
      flash[:danger] = "Oops! It seems that user has been kicked out or never existed in our record!"
      redirect_to root_path
    end
  end

  def fetch_users
    @users = User.all
  end

  def fetch_posts_for_user_show
    @post = Post.new
    @posts = Post.authored_by(@user)
  end
end
