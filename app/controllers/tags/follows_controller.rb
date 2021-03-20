module Tags
  class FollowsController < FollowsController
    before_action :set_followable

    private

    def set_followable
      @followable = Tag.find(params[:tag_id])
    end
  end
end