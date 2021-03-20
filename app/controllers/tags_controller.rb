class TagsController < ApplicationController
  before_action :set_tag, only: :show

  def index
    @tags = Tag.where.not(taggings_count: 0).all
  end

  def show
    @photos = Photo.tagged_with(@tag.name)
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
