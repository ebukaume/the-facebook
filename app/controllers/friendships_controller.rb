# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    flash[:notice] = current_user.request_friendship(params[:user])
    redirect_back fallback_location: root_path
  end

  def index
    @user = User.find_by(id: params[:user]) || current_user
    @friends = Friendship.confirmed_friends @user
    @mutuals = Friendship.mutual_friends(current_user, @user)
  end

  def update
    flash[:notice] = Friendship.confirm_friendship(current_user, params[:id])
    redirect_back fallback_location: root_path
  end

  def requests
    @friends = Friendship.pending_requests current_user
  end

  def requests_sent
    @friends = Friendship.pending_friends current_user
    render 'requests'
  end

  def mutual_friends
    @user = User.find_by(id: params[:user])
    redirect_to(friends_path) && return if @user.nil? || @user == current_user
    @friends = Friendship.confirmed_friends @user
    @mutuals = Friendship.mutual_friends(current_user, @user)
    render 'index'
  end

  def destroy
    flash[:notice] = Friendship.delete_friendship(current_user, params[:id])
    redirect_back fallback_location: root_path
  end
end
