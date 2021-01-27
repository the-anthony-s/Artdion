class PagesController < ApplicationController
  def index
    @photos = Photo.default_order.all

    respond_to do |format|
      format.html
    end
  end
end
