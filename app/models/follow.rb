class Follow < ApplicationRecord
  # Relationships
  belongs_to :user
  belongs_to :followable, polymorphic: true, counter_cache: :followers_count
  belongs_to :follower, polymorphic: true, counter_cache: :following_count

  # Scope
  scope :default_order, -> { order(created_at: :desc) }
end
