class ClassificationsController < ApplicationController
  before_action :set_classification, only: :show

  def index
    @classifications = Classification.includes([:translations]).default_order.all
  end

  def show
    @photos = @classification.photos.default_order.includes([:user]).all
    @tags = ActsAsTaggableOn::Tag.joins(:taggings).where(
      taggings: {
        taggable_type: 'Photo', taggable_id: @photos.pluck(:id)
      }
    ).take(20).uniq
  end

  private

  def set_classification
    @classification = Classification.find(params[:id])
  end
end