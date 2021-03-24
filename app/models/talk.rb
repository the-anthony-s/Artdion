# == Schema Information
#
# Table name: talks
#
#  id                :bigint           not null, primary key
#  body              :text
#  comments_count    :integer          default(0)
#  impressions_count :integer
#  name              :string
#  talkable_type     :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  talkable_id       :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_talks_on_talkable  (talkable_type,talkable_id)
#  index_talks_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
