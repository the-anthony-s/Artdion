class Like < ApplicationRecord
  # RELATIONSHIPS
  belongs_to :user, counter_cache: true
  belongs_to :likable, polymorphic: true, counter_cache: true
end
