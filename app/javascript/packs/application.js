require("@hotwired/turbo-rails")
require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")

// window.Rails = Rails
window.jQuery = $;
window.$ = $;

// Components
import 'components/dropDown'
import 'components/search'

// Check website theme
window.matchMedia('(prefers-color-scheme: dark)').matches