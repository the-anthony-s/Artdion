class TypesController < ApplicationController
  before_action :set_type, only: :show

  def index
    @types = Type.includes([:translations]).default_order.all
  end

  def show
    # Count views
    impressionist(@type)

    @pagy, @photos = pagy @type.photos.default_order.includes([:user]).all

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

  def set_type
    @type = Type.find(params[:id])
  end
end