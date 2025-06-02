import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["searchBar","filtersForm"]

  toggle() {
    const element = this.searchBarTarget;
    const form = this.filtersFormTarget
    // If display is none or empty (initial), hide or show accordingly
    if (form.style.display === "none" || form.style.display === "") {
      form.style.display = "flex";   // show
    } else {
      form.style.display = "none";   // hide
    }
  }
}


