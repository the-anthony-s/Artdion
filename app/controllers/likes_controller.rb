class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = @likable.likes.where(user_id: current_user.id).first_or_create

    respond_to do |format|
      format.html { redirect_to @likable }
      format.js
    end
  end

  def destroy
    @likable.likes.where(user_id: current_user.id).destroy_all

    respond_to do |format|
      format.html { redirect_to @likable }
      format.js
    end
  end
end