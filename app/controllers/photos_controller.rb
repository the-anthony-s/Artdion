class PhotosController < ApplicationController
  before_action :set_photo, only: %i[edit update]
  before_action :convert_search, only: %i[show]

  def index
    @photos = Photos.all
  end

  def show
    @photo = Photo.includes([:user]).find(params[:id])

    impressionist(@photo)

    @tags = @photo.tags
    @photos = Photo.by_tags(@photo, @tags, 20)
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def convert_search
    # convert search only if the referer 'search' controller
    if request.referer.blank? || Rails.application.routes.recognize_path(request.referrer)[:controller] != 'search'
      return
    end

    referer = CGI.parse(request.referer)['q'][0]
    query_to_convert = Searchjoy::Search.where(normalized_query: referer).last
    query_to_convert&.convert(@photo)
  end
end
