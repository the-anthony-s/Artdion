class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    return nil if user_signed_in? && current_user == @followable

    @follow = @followable.following.where(
      user_id: current_user.id,
      follower: current_user,
      followable: @followable
    ).first_or_create

    respond_to do |format|
      format.html { redirect_to @followable }
      format.js
    end
  end

  def destroy
    @followable.following.where(
      user_id: current_user.id
    ).destroy_all

    respond_to do |format|
      format.html { redirect_to @followable }
      format.js
    end
  end
end