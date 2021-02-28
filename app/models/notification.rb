class Notification < ApplicationRecord
  ###############
  # Relationships
  belongs_to :recipient, class_name: 'User'
  belongs_to :actor, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  ###############
  # Scopes
  scope :unread, -> { where(read_at: nil) }
  scope :recent, -> { order(created_at: :desc).limit(5) }

  ###############
  # Create notification
  def self.notify(actor, recipient, notifiable, action)
    # return if actor == recipient

    create(
      actor: actor,
      recipient: recipient,
      notifiable: notifiable,
      action: action
    )
  end
end
