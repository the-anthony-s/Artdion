class TalksController < ApplicationController
  before_action :set_talk, only: %i[show]

  def index
    @talks = Talk.default_order.includes(%i[user talkable]).all
  end

  def show
    # Count views
    impressionist(@talk)

    @recommended = Talk.recommendation_order.tagged_with(
      @talk.tags, any: true
    )
  end

  private

  def set_talk
    @talk = Talk.find(params[:id])
  end
end
