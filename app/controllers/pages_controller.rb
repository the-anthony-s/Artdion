class PagesController < ApplicationController
  def index
    @pagy, @photos = pagy(Photo.default_order.includes([:user]).all, items: 20)

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

  def following
    @pagy, @photos = pagy Photo.where(
      user_id: Follow.where(user_id: current_user.id, followable_type: 'User').default_order.pluck(:followable_id)
    ).includes([:user]).default_order

    respond_to do |format|
      format.html
      format.json {
        rendor json: {
          entries: render_to_string(
            partial: 'photos/photos',
            collection: @photos,
            formats: [:html]
          ),
          pagination: view_context.pagy_nav(@pagy)
        }
      }
    end
  end
end
