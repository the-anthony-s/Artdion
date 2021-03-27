import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// window.Rails = Rails
window.jQuery = $;
window.$ = $;

// Components
import 'components/time'
import 'components/dropDown'
import 'components/fileUpload'
import 'components/search'
import 'components/nav'
import 'components/form'
import 'components/notification'
import 'components/masonry'

// Lazaysizes - lazyload for images
import 'lazysizes'
import 'lazysizes/plugins/parent-fit/ls.parent-fit'

// Stimulus JS
import 'controllers'

// Check website theme
window.matchMedia('(prefers-color-scheme: dark)').matches