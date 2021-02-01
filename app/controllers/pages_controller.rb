class PagesController < ApplicationController
  def index
    @pagy, @photos = pagy Photo.default_order.includes([:user]).all

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
end
