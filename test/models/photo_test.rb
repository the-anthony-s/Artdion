# == Schema Information
#
# Table name: photos
#
#  id                :bigint           not null, primary key
#  active            :boolean          default(TRUE)
#  alt_text          :string
#  description       :text
#  download          :boolean          default(TRUE)
#  image_data        :text
#  impressions_count :integer
#  latitude          :float
#  likes_count       :integer          default(0)
#  location          :string
#  longitude         :float
#  name              :string
#  on_sale           :boolean          default(TRUE)
#  photo_of_the_day  :datetime
#  private           :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :bigint
#
# Indexes
#
#  index_photos_on_user_id  (user_id)
#
require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
