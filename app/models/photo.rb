class Photo < ApplicationRecord
  # TURBO
  # after_create_commit { broadcast_prepend_to 'photos' }
  # after_update_commit { broadcast_replace_to 'photos' }
  # after_destroy_commit { broadcast_remove_to 'photos' }

  #####################################
  # Scope
  scope :default_order, -> { order(created_at: :desc).where(private: false, active: true) }
  scope :user_order, -> { order(created_at: :desc) }
  scope :search_import, -> { includes(:tags, :user).where(private: false, active: true) }

  #####################################
  # References
  belongs_to :user
  belongs_to :type

  has_one :talk, as: :talkable
  has_many :likes, as: :likable
  # has_many :comments, as: :commentable

  # Counters
  # counter_culture :user, column_name: ->(model) { "#{model.state}_photos_count" }
  counter_culture :user
  counter_culture :type, column_name: proc { |model|
    !model.private? && model.active? ? 'photos_count' : nil
  }

  #####################################
  # Tags
  acts_as_taggable_on :tags

  #####################################
  # Impressions -> Count views
  is_impressionable counter_cache: true, unique: true

  #####################################
  # Geocoder
  geocoded_by :address
  after_validation :geocode, if: ->(obj) { obj.address_changed? }

  def address
    location
  end

  def address_changed?
    location_changed?
  end

  #####################################
  # Validation
  include ImageUploader::Attachment(:image)

  validates_presence_of :name
  validates_presence_of :image
  validates_presence_of :type_id

  #####################################
  # Search -> Searchkick gem
  extend Pagy::Search

  searchkick callbacks: :async,
             match: :word_middle,
             conversions: :conversions,
             searchable: %i[name default location username tag],
             suggest: %i[default location username tag],
             stem: true,
             special_characters: true,
             stem_conversions: true,
             case_sensitive: false

  def search_data
    {
      name: name,
      default: "#{name} #{tags.map(&:name).join(' ')} #{user.first_name} #{user.last_name} #{user.username}",
      location: location,
      username: "@#{user.username}",
      tag: tags.map(&:name),
      conversions: map_conversions
    }
  end

  def map_conversions
    results = Searchjoy::Search.where(convertable_id: id)
    results.each_with_object(Hash.new(0)) { |element, result| result[element.query] += 1 }
  end

  def pagy_get_items(collection, pagy)
    collection.offset(pagy.offset).limit(pagy.items)
  end

  #####################################
  # Check if photo is downloadable
  def downloadable?
    return true if download

    false
  end

  #####################################
  # Create talk after save
  after_create :create_talk
  before_save :change_talk_name

  def create_talk
    Talk.create(
      user: user,
      talkable: self,
      name: "#{name.to_s.capitalize} discussion",
      tag_list: "#{self.class.to_s.downcase}, #{type.name.to_s.downcase}"
    )
  end

  def change_talk_name
    talk.update(name: "#{name} dicussion") if name_changed?
  end
end
