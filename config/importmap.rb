# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin 'trix'
pin '@rails/actiontext', to: 'actiontext.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin "stimulus-rails-autosave", to: "https://ga.jspm.io/npm:stimulus-rails-autosave@4.0.0/dist/stimulus-rails-autosave.es.js"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@6.1.7/lib/assets/compiled/rails-ujs.js"
pin "lodash", to: "https://ga.jspm.io/npm:lodash@4.17.21/lodash.js"
pin "debounce", to: "https://ga.jspm.io/npm:debounce@1.2.1/index.js"
pin "loadsh", to: "https://ga.jspm.io/npm:loadsh@0.0.4/lodash.js"
