# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :fetch_likeable

  def create
    flash[:post_notice] = current_user.like(@likeable)
    redirect_to back_with_anchor anchor: @likeable.id
  end

  def destroy
    flash[:post_notice] = current_user.dislike(@likeable)
    redirect_to back_with_anchor anchor: @likeable.id
  end

  private

  def fetch_likeable
    return if (@likeable = Post.find_by(id: params[:id]) ||
     @likeable = Comment.find_by(id: params[:id]))

    flash[:post_notice] = 'Oops! the resource you wish to interact with has been removed or never existed!'
    redirect_back fallback_location: root_path
  end
end
