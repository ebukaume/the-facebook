class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def unauthenticated
    @user = User.new
  end
end
