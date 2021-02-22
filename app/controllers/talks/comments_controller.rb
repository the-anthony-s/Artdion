module Talks
  class CommentsController < CommentsController
    before_action :set_commentable

    private

    def set_commentable
      @commentable = Talk.find(params[:talk_id])
    end
  end
end