module PhotosHelper
  def photo(photo, _type = :default)
    # src - low-quality media
    # data-src - original media
    ratio = photo.image.width.to_f / photo.image.height

    content_tag(:div, class: 'photo-container', style: "--aspect-ratio: #{ratio}") do
      if Rails.env.production?
        # Display image from Imgix if production
        if _type == :card
          card_photo(photo)
        else
          view_photo(photo)
        end
      else
        # Display image from the Cloud server
        # or local server if not production
        image_tag(
          photo.image_url(:S100),
          class: 'lazyload photo',
          alt: photo.alt_text || "#{photo.name} by #{name(photo.user)} (#{username(photo.user)})",
          'data-src': photo.image_url,
          'data-sizes': 'auto'
        )
      end
    end
  end

  # returns card photo
  def card_photo(photo)
    ix_image_tag(
      URI(photo.image_url).path,
      url_params: { w: 1000, q: 80 },
      attribute_options: {
        src: 'data-src',
        srcset: 'data-srcset',
        sizes: 'data-sizes'
      },
      tag_options: {
        'data-sizes': 'auto',
        alt: photo.alt_text || "#{photo.name} by #{name(photo.user)} (#{username(photo.user)})",
        class: 'lazyload photo'
        # src: 'low-quality-media'
      }
    )
  end

  # returns photo view
  def view_photo(photo)
    ix_image_tag(
      URI(photo.image_url).path,
      url_params: {
        w: 1000, q: 80, auto: 'format', fit: 'crop'
      },
      attribute_options: {
        src: 'data-src',
        srcset: 'data-srcset',
        sizes: 'data-sizes'
      },
      tag_options: {
        class: 'lazyload photo',
        alt: photo.alt_text || "#{photo.name} by #{name(photo.user)} (#{username(photo.user)})",
        'data-sizes': 'auto'
        # src: 'low-quality media'
      }
    )
  end
end