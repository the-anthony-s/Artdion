class PagesController < ApplicationController
  def index
    @photos = Photo.default_order.all
  end
end
