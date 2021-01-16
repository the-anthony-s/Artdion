class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable,
         authentication_keys: [:login]

  # References
  has_many :photos

  ## Fields
  include ImageUploader::Attachment(:image)

  validate :validate_username
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true
  validates_presence_of :first_name, :last_name

  ## Friendly ID
  extend FriendlyId
  friendly_id :username, use: :slugged

  ## Check if model liked
  def likes?(likable)
    likable.likes.where(user_id: id).exists?
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
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def validate_username
    errors.add(:username, :invalid) if User.where(email: username).exists?
  end

  private

  # change slug if user's username updated
  def should_generate_new_friendly_id?
    username_changed?
  end
end
