module CommentsHelper
  def reply_to_comment_id(comment, nesting, max_nesting)
    # Use the comment as the parent if we allow unlimited nesting
    # or if it's inside the allowed nesting
    if max_nesting.blank? || nesting < max_nesting
      comment.id
    else
      # Otherwise, we want to the comment's parent
      # and just nest the new comment as a sibling
      comment.parent_id
    end
  end

  def reply_to_user_id(comment, _user)
    comment.user_id if comment.user_id? && comment.user_id != current_user.id
  end

  def related_to_comment_id(comment)
    comment.id
  end
end
