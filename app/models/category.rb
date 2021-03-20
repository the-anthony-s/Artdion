class Category < ApplicationRecord
  translates :name, :description

  #####################################
  # Relationships
  has_many :followers, as: :follower, dependent: :delete_all, class_name: 'Follow'
  has_many :following, as: :followable, dependent: :delete_all, class_name: 'Follow'

  #####################################
  # Impressions -> Count views
  is_impressionable counter_cache: true, unique: true

  #####################################
  # Scope
  scope :default_order, -> { where(active: true) }
  scope :selection_order, -> { where(active: true) }

  #####################################
  # Tags
  acts_as_taggable_on :tags
end