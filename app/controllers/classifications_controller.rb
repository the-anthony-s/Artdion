class ClassificationsController < ApplicationController
  before_action :set_classification, only: :show

  def index
    @classifications = Classification.includes([:translations]).default_order.all
  end

  def show
    # Count views
    impressionist(@classification)

    @pagy, @photos = pagy @classification.photos.default_order.includes([:user]).all

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

  def set_classification
    @classification = Classification.find(params[:id])
  end
end