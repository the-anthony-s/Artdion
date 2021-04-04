class CategoriesController < ApplicationController
  before_action :set_category, only: :show

  def index
    @categories = Category.includes(%i[categories category_taggings]).roots.default_order.all
  end

  def show
    # Count views
    impressionist(@category)

    @pagy, @photos = pagy Photo.includes([:user]).tagged_with(@category.categories, any: true)

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

  def set_category
    @category = Category.find(params[:id])
  end
end