require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require("@hotwired/turbo-rails")

// window.Rails = Rails
window.jQuery = $;
window.$ = $;

// Components
import 'components/time'
import 'components/dropDown'
import 'components/fileUpload'
import 'components/search'

// Stimulus JS
import 'controllers'

// Check website theme
window.matchMedia('(prefers-color-scheme: dark)').matches

// Use 'DOMContentLoaded' event if not using Turbolinks
import { singleFileUpload, multipleFileUpload } from 'components/fileUpload'

document.addEventListener('turbo:load', () => {
  document.querySelectorAll('input[type=file]').forEach(fileInput => {
    if (fileInput.multiple) {
      multipleFileUpload(fileInput)
    } else {
      singleFileUpload(fileInput)
    }
  })
})
