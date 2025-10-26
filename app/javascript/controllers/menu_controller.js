import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    document.addEventListener("click", (e) => {
      if (!this.element.contains(e.target)) {
        this.hideMenu()
      }
    })
  }

  toggleMenu() {
    this.menuTarget.classList.toggle("hidden")
  }

  hideMenu() {
    this.menuTarget.classList.add("hidden")
  }
}