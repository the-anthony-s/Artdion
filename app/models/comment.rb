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
class Comment < ApplicationRecord
  acts_as_paranoid

  # Turbo
  # after_create_commit { broadcast_prepend_to 'comments' }
  # after_update_commit { broadcast_replace_to 'comments' }
  # after_destroy_commit { broadcast_remove_to 'comments' }

  # Relationships
  belongs_to :user
  belongs_to :comment, optional: true
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: 'Comment'

  has_many :likes, as: :likable

  # Counter cache
  counter_culture :user
  counter_culture :commentable
  counter_culture :parent
  # counter_culture :user, column_name: ->(model) { "#{model.state}_photos_count" }

  # Validation
  validates :body, presence: true

  # Scope
  scope :default_order, -> { order(created_at: :asc).with_deleted }

  def comments
    Comment.where(commentable: commentable, parent_id: id)
  end

  # display deleted user
  def user
    User.with_deleted.find(user_id)
  end
end
