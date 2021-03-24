# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text
#  commentable_type :string           not null
#  comments_count   :integer          default(0)
#  deleted_at       :datetime
#  likes_count      :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  comment_id       :bigint
#  commentable_id   :bigint           not null
#  parent_id        :integer
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_comment_id   (comment_id)
#  index_comments_on_commentable  (commentable_type,commentable_id)
#  index_comments_on_deleted_at   (deleted_at)
#  index_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
