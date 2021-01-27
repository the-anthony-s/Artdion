class UsersController < ApplicationController
  before_action :set_user, only: %i[show likes]

  def show
    return @photos = @user.photos.user_order.all if user_signed_in? && (@user == current_user)

    @photos = @user.photos.default_order.all
  end

  def likes
    @photos = Photo.where(
      id: Like.where(likable_type: 'Photo', user_id: @user.id).pluck(:likable_id)
    ).default_order.all
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
