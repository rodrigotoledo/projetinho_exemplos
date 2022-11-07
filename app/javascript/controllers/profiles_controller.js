import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  close() {
    let search = document.getElementById('search')
    let results = document.getElementById('results')
    results.innerHTML = ''
    search.value = ''
  }

  search(element){
    element.target.form.requestSubmit();
  }
}
