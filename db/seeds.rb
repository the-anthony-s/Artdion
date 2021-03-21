I18n.locale = :en

# create photographs
photographs = Category.create(name: 'Photographs', description: 'Something about photographs...')
photographs.tag_list.add('photo', 'photography', 'canon', 'nikon', 'panasonic', 'digital camera', 'dslr cameras', 'pentax', 'olympus', 'hasselblad', 'fujifilm', 'nature photography', 'street photography', 'portrait photography', 'travel photography', 'digital photography', 'mobile photography', 'hdr photography', 'landscape photography')
photographs.save

# create paintings
paintings = Category.create(name: 'Paintings', description: 'The expression of ideas and emotions, with the creation of certain aesthetic qualities, in a two-dimensional visual language. The elements of this language—its shapes, lines, colours, tones, and textures—are used in various ways to produce sensations of volume, space, movement, and light on a flat surface.')
paintings.tag_list.add(paintings.name.downcase.to_s, 'modernism', 'impressionism', 'abstract art', 'expressionism', 'cubism', 'surrealism', 'chinese style', 'japanese style of painting', 'indian style', 'mughal miniature paintings', 'rajput paintings', 'tanjore paintings', 'madhubani style', 'oil', 'watercolour', 'pastel', 'acrylic', 'charcoal', 'coloured', 'pencil', 'ink', 'glass', 'ball point pen', 'fresco', 'collage', 'sand', 'spray', 'encaustic', 'gouache', 'tempera', 'digital', 'miniature', 'kalamkari', 'warli', 'phad', 'madhu bani', 'cave', 'gond', 'action', 'aerial', 'anamorphis', 'camaieu', 'casein', 'chiaroscuro', 'divisionism', 'easel', 'foreshortening', 'graffiti', 'grisaille', 'impasto', 'mural', 'panel', 'panorama', 'perspective', 'plein-air', 'scroll', 'sfumato', 'sgraffito', 'sotto in su', 'tachisme', 'tenebrism', 'trompe l’oeil', 'water miscible oil')
paintings.save



# books = Category.create(name: 'Books', description: 'Something about books Category...')
# jewelry = Category.create(name: 'Costume and Jewelry', description: 'Something about Costume and Jewelry...')
# decorative = Category.create(name: 'Decorative Arts and Utilitarian Objects', description: 'Something about books...')
# drawings = Category.create(name: 'Drawings', description: 'Something about drawings...')
# installations = Category.create(name: 'Installations', description: 'Something about installations...')
# paintings = Category.create(name: 'Paintings', description: 'Something about paintings...')
# photographs = Category.create(name: 'Photographs', description: 'Something about photographs...')
# plates = Category.create(name: 'Plates', description: 'Something about plates...')
# prints = Category.create(name: 'Prints', description: 'Something about prints...')
# sculpture = Category.create(name: 'Sculpture', description: 'Something about sculpture...')
# textiles = Category.create(name: 'Textiles', description: 'Something about textiles...')

# I18n.locale = :ru
# books.update(name: 'Книги', description: 'Что-то крутое про книги...')
# jewelry.update(name: 'Костюмы и украшения', description: 'Something about Costume and Jewelry...')
# decorative.update(name: 'Декоративно-прикладное искусство и предметы быта', description: 'Something about books...')
# drawings.update(name: 'Рисунки', description: 'Something about drawings...')
# installations.update(name: 'Установки', description: 'Something about installations...')
# paintings.update(name: 'Картины', description: 'Something about paintings...')
# photographs.update(name: 'Фотографии', description: 'Something about photographs...')
# plates.update(name: 'Тарелки', description: 'Something about plates...')
# prints.update(name: 'Печать', description: 'Something about prints...')
# sculpture.update(name: 'Скульптура', description: 'Something about sculpture...')
# textiles.update(name: 'Текстиль', description: 'Something about textiles...')

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