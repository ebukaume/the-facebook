# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    flash[:notice] = current_user.request_friendship(params[:user])
    redirect_back fallback_location: root_path
  end

  def index
    @user = User.find_by(id: params[:user]) || current_user
    @friends = @user.friendships.confirmed_friends
  end

  def update
    flash[:notice] = Friendship.confirm_friendship(current_user, params[:id])
    redirect_back fallback_location: root_path
  end

  def user_friends
    @user = User.find_by(id: params[:user])
    redirect_to(friends_path) && return unless user
    @friends = @user.friendships.confirmed_friends
    render 'index'
  end

  def requests
    @friends = current_user.inverse_friendships.pending_inverse
  end

  def requests_sent
    @friends = current_user.friendships.pending_friends
    render 'requests'
  end

  def mutual; end

  def destroy
    flash[:notice] = Friendship.delete_friendship(current_user, params[:id])
    redirect_back fallback_location: root_path
  end
end
