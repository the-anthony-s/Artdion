module Categories
  class FollowsController < FollowsController
    before_action :set_followable

    private

    def set_followable
      @followable = Category.find(params[:category_id])
    end
  end
end