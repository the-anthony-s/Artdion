module ClassificationsHelper
  def classification_cover(photo)
    image_tag(
      photo.image_url(:S100),
      class: 'media art-media lazy',
      alt: photo.name,
      sizes: '(min-width: 1335px) 416px,
              (min-width: 992px) calc(calc(100vw - 72px) / 3),
              (min-width: 768px) calc(calc(100vw - 48px) / 2), 100vw',
      'data-original-set': photo.image_url,
      srcset: "#{photo.image_url(:S100)} 100w, #{photo.image_url(:S200)} 200w,
              #{photo.image_url(:S300)} 300w, #{photo.image_url(:S400)} 400w,
              #{photo.image_url(:S500)} 500w, #{photo.image_url(:S600)} 600w,
              #{photo.image_url(:S700)} 700w, #{photo.image_url(:S800)} 800w,
              #{photo.image_url(:S900)} 900w, #{photo.image_url(:S1000)} 1000w,
              #{photo.image_url(:S1100)} 1100w, #{photo.image_url(:S1200)} 1200w,
              #{photo.image_url(:S1296)} 1296w, #{photo.image_url(:S1400)} 1400w,
              #{photo.image_url(:S1600)} 1600w, #{photo.image_url(:S1800)} 1800w,
              #{photo.image_url(:S2000)} 2000w, #{photo.image_url(:S2200)} 2200w,
              #{photo.image_url(:S2400)} 2400w, #{photo.image_url(:S2592)} 2592w",
      itemprop: 'thumbnailUrl',
      cached: true
    )
  end
end
