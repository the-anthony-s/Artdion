import Masonry from 'masonry-layout'

document.addEventListener('turbolinks:load', function() {
  var grid = document.querySelector('.grid--photos, .grid--photosRelated');
  var msnry = new Masonry(grid, {
    itemSelector: '.col',
    percentPosition: true,
    transitionDuration: 0
  });
})