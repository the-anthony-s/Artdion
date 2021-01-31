class Tag < ApplicationRecord
  # Scope
  scope :default_order, -> { order(taggings_count: :desc).where.not(taggings_count: nil) }

  # Searchkick
  searchkick callbacks: :async,
             match: :word_start,
             conversions: :conversions,
             searchable: %i[name],
             suggest: %i[name],
             stem: true,
             special_characters: true,
             stem_conversions: true,
             case_sensitive: false

  def search_data
    {
      name: name,
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
end