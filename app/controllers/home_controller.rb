# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :load_home_page_resources

  def index; end

  private

  def load_home_page_resources
    if user_signed_in?
      @post = Post.new
      @posts = Post.visible_to_user
    else
      @user = User.new
    end
  end
end
