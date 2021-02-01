class UsersController < ApplicationController
  before_action :set_user, only: %i[show likes]

  def show
    # Count views
    impressionist(@user)

    if user_signed_in? && (@user == current_user)
      @pagy, @photos = pagy @user.photos.user_order.all
    else
      @pagy, @photos = pagy @user.photos.default_order.all
    end

    respond_to do |format|
      format.html
      format.json {
        render json: {
          entries: render_to_string(
            partial: 'photos/photo',
            collection: @photos,
            locals: { show_user: false },
            formats: [:html]
          ),
          pagination: view_context.pagy_nav(@pagy)
        }
      }
    end
  end

  def likes
    @pagy, @photos = pagy Photo.where(
      id: Like.where(likable_type: 'Photo', user_id: @user.id).pluck(:likable_id)
    ).default_order.includes([:user]).all

    respond_to do |format|
      format.html
      format.json {
        render json: {
          entries: render_to_string(
            partial: 'photos/photo',
            collection: @photos,
            formats: [:html]
          ),
          pagination: view_context.pagy_nav(@pagy)
        }
      }
    end
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
