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

// Lazaysizes - lazyload for images
import 'lazysizes';
import 'lazysizes/plugins/parent-fit/ls.parent-fit';

// Stimulus JS
import 'controllers'

// Check website theme
window.matchMedia('(prefers-color-scheme: dark)').matches

// Use 'DOMContentLoaded' event if not using Turbolinks
// import { singleFileUpload, multipleFileUpload } from 'components/fileUpload'

// document.addEventListener('turbolinks:load', () => {
//   document.querySelectorAll('input[type=file]').forEach(fileInput => {
//     if (fileInput.multiple) {
//       multipleFileUpload(fileInput)
//     } else {
//       singleFileUpload(fileInput)
//     }
//   })
// })