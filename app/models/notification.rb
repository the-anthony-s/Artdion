# == Schema Information
#
# Table name: notifications
#
#  id              :bigint           not null, primary key
#  action          :string
#  notifiable_type :string
#  read_at         :datetime
#  relatable_type  :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  actor_id        :integer
#  notifiable_id   :integer
#  recipient_id    :integer
#  relatable_id    :integer
#
class Notification < ApplicationRecord
  ###############
  # Relationships
  belongs_to :recipient, class_name: 'User'
  belongs_to :actor, class_name: 'User'
  belongs_to :notifiable, polymorphic: true
  belongs_to :relatable, polymorphic: true

  ###############
  # Scopes
  scope :unread, -> { where(read_at: nil) }
  scope :recent, -> { order(created_at: :desc).limit(5) }

  ###############
  # Create notification
  def self.notify(actor, recipient, notifiable, relatable, action)
    # return if actor == recipient

    create(
      actor: actor,
      recipient: recipient,
      notifiable: notifiable,
      relatable: relatable,
      action: action
    )
  end
end
