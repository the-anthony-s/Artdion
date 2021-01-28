class ClassificationsController < ApplicationController
  before_action :set_classification, only: :show

  def index
    @classifications = Classification.includes([:translations]).default_order.all
  end

  def show
    @photos = @classification.photos.default_order.all
  end

  private

  def set_classification
    @classification = Classification.find(params[:id])
  end
end
