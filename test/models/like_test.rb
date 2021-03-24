# == Schema Information
#
# Table name: likes
#
#  id           :bigint           not null, primary key
#  likable_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  likable_id   :bigint
#  user_id      :bigint
#
# Indexes
#
#  index_likes_on_likable_type_and_likable_id  (likable_type,likable_id)
#  index_likes_on_user_id                      (user_id)
#
require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
