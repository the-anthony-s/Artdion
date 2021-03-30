I18n.locale = :en

# create photographs
# photographs = Category.create(name: 'Photographs', description: "Something about photographs...")
# photographs.category_list = ("#{photographs.name.downcase}, photo, photography, canon, nikon, panasonic, digital camera, dslr cameras, pentax, olympus, hasselblad, fujifilm, nature photography, street photography, portrait photography, travel photography, digital photography, mobile photography, hdr photography, landscape photography")
# photographs.save

art = Category.create(name: 'Art Movements')
art.category_list = ("#{art.name}, art, painting")
art.save

abstract = art.children.create(name: 'Abstract expressionism')
abstract.category_list = ("#{abstract.name}, abstract")
abstract.save


# Language.create(
#   name: 'English',
#   name_native: 'English',
#   iso_639_1: 'en',
#   iso_639_3: 'eng',
#   iso_639_2b: 'eng',
#   iso_639_2t: 'eng',
#   pause: false
# )

# Language.create(
#   name: 'Russian',
#   name_native: 'Русский',
#   iso_639_1: 'ru',
#   iso_639_3: 'rus',
#   iso_639_2b: 'rus',
#   iso_639_2t: 'rus',
#   pause: false
# )

# Language.create(
#   name: 'Spanish',
#   name_native: 'Español',
#   iso_639_1: 'es',
#   iso_639_3: 'spa',
#   iso_639_2b: 'spa',
#   iso_639_2t: 'spa',
#   pause: true
# )

# Language.create(
#   name: 'French',
#   name_native: 'Français',
#   iso_639_1: 'fr',
#   iso_639_3: 'fra',
#   iso_639_2b: 'fre',
#   iso_639_2t: 'fra',
#   pause: true
# )
