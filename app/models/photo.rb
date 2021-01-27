class Photo < ApplicationRecord
  # TURBO
  # after_create_commit { broadcast_prepend_to 'photos' }
  # after_update_commit { broadcast_replace_to 'photos' }
  # after_destroy_commit { broadcast_remove_to 'photos' }

  # Scope
  scope :default_order, -> { order(created_at: :desc).where(private: false, active: true) }
  scope :user_order, -> { order(created_at: :desc) }
  # scope :search_import, -> { includes(:tags, :user).where(private: false, active: true) }

  # References
  belongs_to :user

  # Counter cache
  counter_culture :user
  # counter_culture :user, column_name: ->(model) { "#{model.state}_photos_count" }

  has_many :likes, as: :likable
  has_many :comments, as: :commentable

  # Tags
  acts_as_taggable_on :tags

  # Validation
  include ImageUploader::Attachment(:image)
  validates_presence_of :image

  # Check if photo is downloadable
  def downloadable?
    return true if download

    false
  end
end
