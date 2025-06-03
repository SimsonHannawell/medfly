import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  increment(event) {
    const input = event.currentTarget.parentElement.querySelector(".quantity-input");
    input.value = parseInt(input.value || "0") + 1;
    input.dispatchEvent(new Event("input", { bubbles: true }));
  }

  decrement(event) {
    const input = event.currentTarget.parentElement.querySelector(".quantity-input");
    let newValue = parseInt(input.value || "1") - 1;
    if (newValue < 1) newValue = 1;
    input.value = newValue;
    input.dispatchEvent(new Event("input", { bubbles: true }));
  }

  updateQuantity(event) {
    this.submit(event);
  }

  submit(event) {
    const form = event.target.closest("form");
    if (form) form.requestSubmit();
  }
}
