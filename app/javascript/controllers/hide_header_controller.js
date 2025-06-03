// app/javascript/controllers/hide_header_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["header"]

  connect() {
    this.lastScrollTop = window.scrollY
    this.handleScroll = this.handleScroll.bind(this)
    window.addEventListener("scroll", this.handleScroll)
  }

  disconnect() {
    window.removeEventListener("scroll", this.handleScroll)
  }

  handleScroll() {
    const currentScroll = window.scrollY

    if (currentScroll > this.lastScrollTop + 10) {
      // Scrolling down
      this.headerTarget.classList.add("hide-header")
    } else if (currentScroll < this.lastScrollTop - 10) {
      // Scrolling up
      this.headerTarget.classList.remove("hide-header")
    }

    this.lastScrollTop = currentScroll <= 0 ? 0 : currentScroll
  }
}


