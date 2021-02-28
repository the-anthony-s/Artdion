class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    # Create notification

    respond_to do |format|
      if @comment.save
        Notification.notify(current_user, @commentable.user, @comment, 'replied')

        format.html { redirect_to @commentable, notice: 'Cool!' }
        format.json { render :show, status: :created, location: @commentable }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@comment, partial: 'comments/form', locals: { comment: @comment }) }
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy

    redirect_to @commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id, :comment_id)
  end
end
