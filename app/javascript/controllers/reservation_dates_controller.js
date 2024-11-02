import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["start", "end"];

  connect() {
    // Mettre à jour la date minimale de fin quand la date de début change
    this.startTarget.addEventListener("change", () => {
      const startDate = this.startTarget._flatpickr.selectedDates[0];
      if (startDate) {
        this.endTarget._flatpickr.set("minDate", startDate);
      }
    });

    // S'assurer que la date de fin est après la date de début
    this.endTarget.addEventListener("change", () => {
      const startDate = this.startTarget._flatpickr.selectedDates[0];
      const endDate = this.endTarget._flatpickr.selectedDates[0];

      if (startDate && endDate && endDate < startDate) {
        this.endTarget._flatpickr.setDate(startDate);
      }
    });
  }
}
