# I18n.locale = :en

# create photographs
# photographs = Category.create(name: 'Photographs', description: "Something about photographs...")
# photographs.category_list = ("#{photographs.name.downcase}, photo, photography, canon, nikon, panasonic, digital camera, dslr cameras, pentax, olympus, hasselblad, fujifilm, nature photography, street photography, portrait photography, travel photography, digital photography, mobile photography, hdr photography, landscape photography")
# photographs.save

art = Category.create(name: 'Art Movements')
art.category_list = ("#{art.name}, art, painting")
art.save

# ABSTRACT EXPRESSIONSIM
abstract_expressionism = art.children.create(name: 'Abstract expressionism')
abstract_expressionism.category_list = ('abstract expressionism art')
abstract_expressionism.save

# ABSTRACT IMPRESSIONISM
abstract_impressionism = art.children.create(name: 'Abstract impressionism')
abstract_impressionism.category_list = ('abstract impressionism art')
abstract_impressionism.save

# ACADEMIC ART
academic_art = art.children.create(name: 'Academic art')
academic_art.category_list = ('academic art')
academic_art.save

# AESTHETICISM
aestheticism = art.children.create(name: 'Aestheticism')
aestheticism.category_list = ('aestheticism art')
aestheticism.save

# AMERICAN IMPRESSIONISM
american_impressionism = art.children.create(name: 'American Impressionism')
american_impressionism.category_list = ('american impressionism art')
american_impressionism.save

# AMERICAN MODERNISM
american_modernism = art.children.create(name: 'American modernism')
american_modernism.category_list = ('american modernism art')
american_impressionism.save

# AMERICAN REALISM
american_realism = art.children.create(name: 'American Realism')
american_realism.category_list = ('american realism art')
american_realism.save

# AMERICAN RENAISSANCE
american_renaissance = art.children.create(name: 'American Renaissance')
american_renaissance.category_list = ('american renaissance art')
american_renaissance.save

# AMSTERDAM IMPRESSIONISM
amsterdam_impressionism = art.children.create(name: 'Amsterdam Impressionism')
amsterdam_impressionism.category_list = ('amsterdam impressionism art')
amsterdam_impressionism.save

# ANTWERP SCHOOL
antwerp_school = art.children.create(name: 'Antwerp school')
antwerp_school.category_list = ('antwerp school art')
antwerp_school.save

# ART DECO
art_deco = art.children.create(name: 'Art Deco')
art_deco.category_list = ('art deco')
art_deco.save

# ART NOUVEAU
art_nouveau = art.children.create(name: 'Art Nouveau')
art_nouveau.category_list = ('art nouveau')
art_nouveau.save

# ARTE POVERA
arte_povera = art.children.create(name: 'Arte Povera')
arte_povera.category_list = ('arte povera art')
arte_povera.save

# ARTS AND CRAFTS MOVEMENT
arts_and_crafts_movement = art.children.create(name: 'Arts and Crafts movement')
arts_and_crafts_movement.category_list = ('arts and crafts movement')
arts_and_crafts_movement.save

# ASHCAN SCHOOL
ashcan_school = art.children.create(name: 'Ashcan School')
ashcan_school.category_list = ('ashcan school art')
ashcan_school.save

Language.create(
  name: 'English',
  name_native: 'English',
  iso_639_1: 'en',
  iso_639_3: 'eng',
  iso_639_2b: 'eng',
  iso_639_2t: 'eng',
  pause: false
)

Language.create(
  name: 'Russian',
  name_native: 'Русский',
  iso_639_1: 'ru',
  iso_639_3: 'rus',
  iso_639_2b: 'rus',
  iso_639_2t: 'rus',
  pause: false
)

Language.create(
  name: 'Spanish',
  name_native: 'Español',
  iso_639_1: 'es',
  iso_639_3: 'spa',
  iso_639_2b: 'spa',
  iso_639_2t: 'spa',
  pause: true
)

Language.create(
  name: 'French',
  name_native: 'Français',
  iso_639_1: 'fr',
  iso_639_3: 'fra',
  iso_639_2b: 'fre',
  iso_639_2t: 'fra',
  pause: true
)