# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  about                  :text
#  comments_count         :integer          default(0)
#  comments_likes_count   :integer          default(0)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  deleted_at             :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  followers_count        :integer          default(0)
#  following_count        :integer          default(0)
#  image_data             :text
#  impressions_count      :integer
#  instagram              :string
#  language               :string
#  last_name              :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  latitude               :float
#  location               :string
#  longitude              :float
#  message                :boolean          default(TRUE)
#  photos_count           :integer          default(0)
#  photos_likes_count     :integer          default(0)
#  preferences            :json
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  slug                   :string
#  timezone               :string
#  twitter                :string
#  unconfirmed_email      :string
#  username               :string
#  website                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_deleted_at            (deleted_at)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#
class User < ApplicationRecord
  acts_as_paranoid without_default_scope: true

  #####################################
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable,
         authentication_keys: [:login]

  #####################################
  ## References
  has_many :photos, dependent: :destroy
  has_many :talks
  has_many :comments
  has_many :likes
  has_many :notifications, foreign_key: :recipient_id
  has_many :followers, as: :follower, dependent: :delete_all, class_name: 'Follow'
  has_many :following, as: :followable, dependent: :delete_all, class_name: 'Follow'
  # has_many :visits, class_name: 'Ahoy::Visit'

  #####################################
  ## Impressions -> Count views
  is_impressionable counter_cache: true, unique: true

  #####################################
  ## Geocoder
  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address_changed? }

  def address
    location
  end

  def address_changed?
    location_changed?
  end

  #####################################
  ## Fields
  include ImageUploader::Attachment(:image)

  validate :validate_username
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { within: 5..20 }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true
  validates_presence_of :first_name, :last_name

  typed_store :preferences, coder: ActiveRecord::TypedStore::IdentityCoder do |t|
    t.boolean :email_announcements, default: true, null: false
    t.boolean :email_updates, default: true, null: false
    t.boolean :email_notifications, default: true, null: false
    t.boolean :email_recommendations, default: true, null: false
    t.boolean :email_tips, default: true, null: false
  end

  #####################################
  ## Tags
  acts_as_tagger
  acts_as_taggable_on :tags

  #####################################
  ## Friendly ID
  extend FriendlyId
  friendly_id :username, use: %i[slugged finders]

  #####################################
  ## Check if model liked
  def likes?(likable)
    likable.likes.where(user_id: id).exists?
  end

  #####################################
  ## Check if model follows
  def follows?(user)
    user.following.where(user_id: id).exists?
  end

  #####################################
  ## User Email and Nickname for login
  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    else
      return where(conditions).first if conditions[:username].nil?

      where(username: conditions[:username]).first
    end
  end

  def validate_username
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  #####################################
  ## Friendly_id: change slug if user's username updated or slug is blank
  def should_generate_new_friendly_id?
    username_changed?
  end
end
