class Like < ApplicationRecord
  # RELATIONSHIPS
  belongs_to :user
  belongs_to :likable, polymorphic: true

  # Counter cache
  counter_culture :user, column_name: proc { |model|
    "#{model.likable.model_name.plural}_likes_count"
  }
  counter_culture :likable

  # Scopes
  scope :default_order, -> { order(created_at: :asc) }
end
