import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  toggle(event) {
    if (event.currentTarget.checked) {
      this.checkboxTargets.forEach((checkbox) => {
        if (checkbox !== event.currentTarget) {
          checkbox.checked = false
        }
      })
    }
  }
}