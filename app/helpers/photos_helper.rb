module PhotosHelper
  def photo_card(photo)
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

  def photo_view(photo)
    image_tag(
      photo.image_url(:S100),
      class: 'media art-media lazy',
      alt: photo.name,
      sizes: '(max-width: 767px) 100vw, (max-width: 532px) 500px,
              (max-height: 554px) 500px,
              (min-aspect-ratio: 5184/3456) calc((calc(100vh - 220px)) * 1.5), 
              calc(100vw - 32px)',
      'data-original-set': photo.image_url,
      srcset: "#{photo.image_url(:S750)} 750w, #{photo.image_url(:S1050)} 1050w,
              #{photo.image_url(:S1350)} 1350w, #{photo.image_url(:S1500)} 1500w,
              #{photo.image_url(:S1650)} 1650w, #{photo.image_url(:S1950)} 1950w,
              #{photo.image_url(:S2100)} 2100w, #{photo.image_url(:S2250)} 2250w,
              #{photo.image_url(:S2550)} 2550w, #{photo.image_url(:S2700)} 2700w,
              #{photo.image_url(:S2850)} 2850w, #{photo.image_url(:S3150)} 3150w,
              #{photo.image_url(:S3300)} 3300w, #{photo.image_url(:S3450)} 3450w,
              #{photo.image_url(:S3750)} 3750w, #{photo.image_url(:S3900)} 3900w,
              #{photo.image_url(:S4050)} 4050w, #{photo.image_url(:S4350)} 4350w,
              #{photo.image_url(:S4500)} 4500w, #{photo.image_url(:S4650)} 4650w,
              #{photo.image_url(:S4950)} 4950w, #{photo.image_url(:S5100)} 5100w,
              #{photo.image_url(:S5184)} 5184w",
      itemprop: 'thumbnailUrl',
      cached: true
    )
  end
end
