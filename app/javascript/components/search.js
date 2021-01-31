// https://github.com/verlok/lazyload
import Bloodhound from "typeahead.js";
import Handlebars from "handlebars";

document.addEventListener('turbo:load', (e) => {
  var $search = $('#searchControl');
  var $form = $('.search');
  var $html = $('html');

  // $(document).on('keydown', (e) => {
  //   if (e.which == 83 && !$search.is(':focus')) {
  //     $search.focus();
  //     $search.val('');
  //     return false;
  //   } else if (e.which == 27) {
  //     $search.blur();
  //   }
  // });

  $search.on('focusin', () => {
    $html.addClass('app-noscroll');
    $form.addClass('search--focused');
  });

  $search.on('focusout', () => {
    $html.removeClass('app-noscroll');
    $form.removeClass('search--focused');
  })


  // Autocomplete
  var engine = new Bloodhound({
    datumTokenizer: function (d) {
      return Bloodhound.tokenizers.whitespace(d.title);
    },
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/s/autocomplete?q=%Q',
      wildcard: '%Q',
      filter: function (data) {
        console.log(data);
        return $.map(data, function (tag) {
          return {
            value: tag.name
          };
        });
      }
    }
  });

  engine.initialize();

  $search.typeahead(null, {
    name: 'engine',
    displayKey: 'value',
    source: engine.ttAdapter(),
    minLength: 1,
    dynamic: true,
    hint: true,
    cache: localStorage,
    compression: true,
    templates: {
      suggestion: Handlebars.compile('<a href="/s?utf8=✓&q={{value}}">{{value}}</a>')
    }
  });
});