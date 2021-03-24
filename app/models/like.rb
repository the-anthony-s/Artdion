# == Schema Information
#
# Table name: likes
#
#  id           :bigint           not null, primary key
#  likable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  likable_id   :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_likes_on_likable_type_and_likable_id  (likable_type,likable_id)
#  index_likes_on_user_id                      (user_id)
#
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
  scope :default_order, -> { order(created_at: :desc) }
end
