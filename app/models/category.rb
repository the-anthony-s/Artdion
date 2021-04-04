# == Schema Information
#
# Table name: categories
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE)
#  ancestry          :string
#  children_count    :integer          default(0)
#  description       :text
#  followers_count   :integer          default(0)
#  impressions_count :integer
#  name              :string
#  users_count       :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_categories_on_ancestry  (ancestry)
#
class Category < ApplicationRecord
  #####################################
  # Relationships
  has_many :followers, as: :follower, dependent: :delete_all, class_name: 'Follow'
  has_many :following, as: :followable, dependent: :delete_all, class_name: 'Follow'

  #####################################
  # Impressions -> Count views
  is_impressionable counter_cache: true, unique: true

  #####################################
  # Scope
  scope :default_order, -> { where(active: true).order(created_at: :desc) }
  scope :selection_order, -> { where(active: true).order(:name) }

  #####################################
  # Tags
  acts_as_taggable_on :categories

  #####################################
  # Ancestry
  has_ancestry counter_cache: true

  #####################################
  # Returns first photo
  def first_photo
    Photo.tagged_with(categories, any: true).first
  end
end
