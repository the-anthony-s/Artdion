class Like < ApplicationRecord
  # RELATIONSHIPS
  belongs_to :user
  belongs_to :likable, polymorphic: true

  # Counter cache
  counter_culture :user
  counter_culture :likable

  # Scopes
  scope :default_order, -> { order(created_at: :asc) }
end
