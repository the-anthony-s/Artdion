class Photo < ApplicationRecord
  # # TURBO
  # after_create_commit { broadcast_prepend_to 'photos' }
  # after_update_commit { broadcast_replace_to 'photos' }
  # after_destroy_commit { broadcast_remove_to 'photos' }

  # Scope
  scope :default_order, -> { order(created_at: :desc).where(private: false, active: true) }
  # scope :search_import, -> { includes(:tags, :user).where(private: false, active: true) }

  # References
  belongs_to :user, counter_cache: true

  has_many :likes, as: :likable

  # Check if photo is downloadable
  def downloadable?
    return true if download

    false
  end
end
