# == Schema Information
#
# Table name: follows
#
#  id              :bigint           not null, primary key
#  followable_type :string
#  follower_type   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  followable_id   :bigint
#  follower_id     :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_follows_on_followable  (followable_type,followable_id)
#  index_follows_on_follower    (follower_type,follower_id)
#  index_follows_on_user_id     (user_id)
#
require "test_helper"

class FollowTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
