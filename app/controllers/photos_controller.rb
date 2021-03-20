class PhotosController < ApplicationController
  before_action :set_photo, only: %i[show edit update]
  before_action :convert_search, only: %i[show]

  def index
    @photos = Photos.all
  end

  def show
    # Count views
    impressionist(@photo)

    @related = Photo.default_order.includes([:user]).where.not(
      id: @photo.id
    ).tagged_with(
      @photo.tags, any: true
    ).take(20)

    if @related.any?
      @tags = ActsAsTaggableOn::Tag.joins(:taggings).where(
        taggings: {
          taggable_type: 'Photo', taggable_id: @related.pluck(:id)
        }
      ).take(30).uniq
    else
      @tags = @photo.tags.all
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def convert_search
    return if request.referer.blank?

    referer = CGI.parse(request.referer)['q'][0]
    query_to_convert = Searchjoy::Search.where(normalized_query: referer).last
    query_to_convert&.convert(@photo)
  end
end