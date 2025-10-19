import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  add(event) {
    event.preventDefault()
    let content = event.currentTarget.dataset.fields
    content = content.replace(/new_record/g, new Date().getTime())
    event.currentTarget.insertAdjacentHTML('beforebegin', content)
  }

  remove(event) {
    event.preventDefault()
    let wrapper = event.target.closest(".nested-fields")

    if (wrapper.dataset.newRecord === "false") {
      wrapper.style.display = 'none'
      let input = wrapper.querySelector("input[name*='_destroy']")
      input.value = '1'
    } else {
      wrapper.remove()
    }
  }
}