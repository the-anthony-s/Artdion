module PagesHelper
  # return photo of the day
  def photo_of_the_day(photo)
    if Rails.env.production?
      ix_image_tag(
        URI(photo.image_url).path,
        url_params: {
          w: 1000,
          h: 1000,
          fit: 'crop',
          auto: 'format'
        },
        attribute_options: {
          src: 'data-src',
          srcset: 'data-srcset',
          sizes: 'data-sizes'
        },
        tag_options: {
          'data-sizes': 'auto',
          alt: "#{photo.name} by #{name(photo.user)} - photo of the day on #{photo.photo_of_the_day.strftime('%d %B, %Y')}",
          class: 'lazyload',
          src: photo.image_url(:S100)
        }
      )
    else
      image_tag(
        photo.image_url(:S100),
        class: 'lazyload',
        alt: "#{photo.name} by #{name(photo.user)} - photo of the day on #{photo.photo_of_the_day.strftime('%d %B, %Y')}",
        'data-src': photo.image_url,
        'data-sizes': 'auto'
      )
    end
  end
end
