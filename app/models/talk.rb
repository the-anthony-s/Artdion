class Talk < ApplicationRecord
  # acts_as_paranoid

  # Relationships
  belongs_to :user
  belongs_to :talkable, polymorphic: true

  has_many :comments, as: :commentable

  # Scope
  scope :default_order, -> { order(created_at: :desc) }
  scope :recommendation_order, lambda {
    order(impressions_count: :desc, created_at: :desc).where.not(comments_count: 0)
  }

  # Tags
  acts_as_taggable_on :tags

  # Impressions -> Count views
  is_impressionable counter_cache: true
end
