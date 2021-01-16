# This is a subclass of Shrine base that will be further configured for it's requirements.
# This will be included in the model to manage the file.

class ImageUploader < Shrine
  ALLOWED_TYPES  = %w[image/jpeg image/png image/webp].freeze
  MAX_SIZE       = 20 * 1024 * 1024 # 20 MB
  MAX_DIMENSIONS = [25_000, 25_000].freeze # 25000x25000

  THUMBNAILS = {
    S100: [100, 100],
    S200: [200, 200],
    S300: [300, 300],
    S400: [400, 400],
    S500: [500, 500],
    S600: [600, 600],
    S700: [700, 700],
    S750: [750, 750],
    S800: [800, 800],
    S900: [900, 900],
    S1000: [1000, 1000],
    S1050: [1050, 1050],
    S1100: [1100, 1100],
    S1200: [1200, 1200],
    S1296: [1296, 1296],
    S1350: [1350, 1350],
    S1400: [1400, 1400],
    S1500: [1500, 1500],
    S1600: [1600, 1600],
    S1650: [1650, 1650],
    S1800: [1800, 1800],
    S1950: [1950, 1950],
    S2000: [2000, 2000],
    S2100: [2100, 2100],
    S2200: [2200, 2200],
    S2250: [2250, 2250],
    S2400: [2400, 2400],
    S2550: [2550, 2550],
    S2592: [2592, 2592],
    S2700: [2700, 2700],
    S2850: [2850, 2850],
    S3150: [3150, 3150],
    S3300: [3300, 3300],
    S3450: [3450, 3450],
    S3750: [3750, 3750],
    S3900: [3900, 3900],
    S4050: [4050, 4050],
    S4350: [4350, 4350],
    S4500: [4500, 4500],
    S4650: [4650, 4650],
    S4950: [4950, 4950],
    S5100: [5100, 5100],
    S5184: [5184, 5184]
  }.freeze

  plugin :remove_attachment
  plugin :pretty_location
  plugin :validation_helpers
  plugin :store_dimensions, log_subscriber: nil
  plugin :derivation_endpoint, prefix: 'derivations/image'

  # File validations (requires `validation_helpers` plugin)
  Attacher.validate do
    validate_size 0..MAX_SIZE

    validate_max_dimensions MAX_DIMENSIONS if validate_mime_type ALLOWED_TYPES
  end

  # Thumbnails processor (requires `derivatives` plugin)
  Attacher.derivatives do |original|
    THUMBNAILS.transform_values do |(width, height)|
      GenerateThumbnail.call(original, width, height) # lib/generate_thumbnail.rb
    end
  end

  # Default to dynamic thumbnail URL (requires `default_url` plugin)
  Attacher.default_url do |derivative: nil, **|
    file&.derivation_url(:thumbnail, *THUMBNAILS.fetch(derivative)) if derivative
  end

  # Dynamic thumbnail definition (requires `derivation_endpoint` plugin)
  derivation :thumbnail do |file, width, height|
    GenerateThumbnail.call(file, width.to_i, height.to_i) # lib/generate_thumbnail.rb
  end
end
