import { Application } from "@hotwired/stimulus";

const application = Application.start()
// application.register('autosave', Autosave)


// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
