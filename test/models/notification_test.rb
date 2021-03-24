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
require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
