# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :fetch_user, :fetch_posts_for_user_show, only: [:show]
  before_action :fetch_users, only: :index

  def index; end

  def show; end

  private

  def fetch_user
    return if (@user = User.find_by(id: params[:id]))

    flash[:danger] = 'Oops! It seems the user you are looking for has been kicked out or never existed in our record!'
    redirect_to root_path
  end

  def fetch_users
    @users = User.all
  end

  def fetch_posts_for_user_show
    @post = Post.new
    @posts = Post.authored_by(@user)
  end
end
