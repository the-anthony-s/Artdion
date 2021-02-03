
class User < ApplicationRecord
  acts_as_tagger
  acts_as_paranoid without_default_scope: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable,
         authentication_keys: [:login]

  ## References
  has_many :photos, dependent: :destroy
  has_many :comments
  has_many :likes
  has_many :followers, as: :follower, dependent: :delete_all, class_name: 'Follow'
  has_many :following, as: :followable, dependent: :delete_all, class_name: 'Follow'
  has_many :visits, class_name: 'Ahoy::Visit'

  ## Impressions -> Count views
  is_impressionable counter_cache: true, unique: true

  ## Fields
  include ImageUploader::Attachment(:image)

  validate :validate_username
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { within: 5..20 }
  validates_format_of :username, with: /^[@a-zA-Z0-9_.](?!\w*__\w*)\w+$/, multiline: true
  validates_presence_of :first_name, :last_name

  ## Friendly ID
  extend FriendlyId
  friendly_id :username, use: %i[slugged finders]

  ## Check if model liked
  def likes?(likable)
    likable.likes.where(user_id: id).exists?
  end

  ## Check if model follows
  def follows?(user)
    user.following.where(user_id: id).exists?
  end

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

  ## Friendly_id: change slug if user's username updated or slug is blank
  def should_generate_new_friendly_id?
    username_changed?
  end
end
