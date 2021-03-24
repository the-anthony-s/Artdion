# == Schema Information
#
# Table name: categories
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE)
#  description       :text
#  followers_count   :integer          default(0)
#  impressions_count :integer
#  name              :string
#  users_count       :integer          default(0)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
