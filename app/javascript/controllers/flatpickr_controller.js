import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.fp = flatpickr(this.element, {
      locale: "fr",
      altInput: true,
      altFormat: "d/m/Y",
      dateFormat: "Y-m-d",
      minDate: "today",
      defaultDate: this.element.value,
      allowInput: true,
      disableMobile: false,
    });
  }

  disconnect() {
    this.fp.destroy();
  }
}
