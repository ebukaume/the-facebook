class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :load_resources

  def index
  end

  private

  def load_resources
    if user_signed_in?
      @post = Post.new
      @posts = Post.recent
    else
      @user = User.new
    end
  end
end
