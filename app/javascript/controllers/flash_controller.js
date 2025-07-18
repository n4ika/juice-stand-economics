import { Controller } from "@hotwired/stimulus";

// Automatically removes a flash banner after X ms
export default class extends Controller {
  static values = { timeout: { type: Number, default: 4000 } };

  connect() {
    setTimeout(() => {
      this.element.classList.add("fade-out");
      // Wait for CSS fade to finish, then remove from DOM
      this.element.addEventListener("transitionend", () =>
        this.element.remove()
      );
    }, this.timeoutValue);
  }
}
