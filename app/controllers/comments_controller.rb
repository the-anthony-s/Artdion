class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @commentable, notice: 'Cool!' }
        format.json { render :show, status: :created, location: @commentable }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@comment, partial: 'comments/form', locals: { comment: @comment }) }
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

    # if @comment.save
    #   redirect_to @commentable
    # else
    #   redirect_to @commentable, alert: 'Something went wrong'
    # end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy

    redirect_to @commentable
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end