import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = []

  connect() {
    // Optional: hide modal on connect
    this.element.style.display = "none"
  }

  open(event) {
    event.preventDefault()
    const modalId = event.currentTarget.dataset.modalId
    const modal = document.getElementById(modalId)
    if (modal) {
      modal.style.display = "block"
    }
  }

  close(event) {
    event.preventDefault()
    this.element.style.display = "none"
  }

  outsideClick(event) {
    if (event.target === this.element) {
      this.close(event)
    }
  }
}

