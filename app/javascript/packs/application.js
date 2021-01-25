require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require("@hotwired/turbo-rails")

// window.Rails = Rails
window.jQuery = $;
window.$ = $;

// Components
import 'components/dropDown'
import 'components/search'

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
import "controllers"
