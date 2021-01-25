module Users
  class FollowsController < FollowsController
    before_action :set_followable

    private

    def set_followable
      @followable = User.friendly.find(params[:user_id])
    end
  end
end