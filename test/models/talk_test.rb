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
require "test_helper"

class TalkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
