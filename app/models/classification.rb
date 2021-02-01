class Classification < ApplicationRecord
  translates :name, :description

  # Relationships
  has_many :photos

  # Impressions -> Count views
  is_impressionable counter_cache: true, unique: true

  # Scope
  scope :default_order, -> { where(active: true).where.not(photos_count: 0) }
  scope :selection_order, -> { where(active: true) }
end