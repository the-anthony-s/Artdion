# == Schema Information
#
# Table name: follows
#
#  id              :bigint           not null, primary key
#  followable_type :string
#  follower_type   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  followable_id   :bigint
#  follower_id     :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_follows_on_followable  (followable_type,followable_id)
#  index_follows_on_follower    (follower_type,follower_id)
#  index_follows_on_user_id     (user_id)
#
class Follow < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :followable, polymorphic: true, counter_cache: :followers_count
  belongs_to :follower, polymorphic: true, counter_cache: :following_count

  # Scope
  scope :default_order, -> { order(created_at: :desc) }
end
