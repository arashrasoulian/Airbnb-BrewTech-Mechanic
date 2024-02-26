import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slideshow"

export default class extends Controller {
  static targets = ["slide"];
  static values = { index: Number };

  connect() {
    this.indexValue = 0;
    this.showSlide();
    this.startInterval();
  }

  next() {
    this.indexValue++;
    this.showSlide();
    this.resetInterval();
  }

  prev() {
    this.indexValue--;
    this.showSlide();
    this.resetInterval();
  }

  showSlide() {
    this.slideTargets.forEach((slide, index) => {
      slide.hidden = index !== this.indexValue % this.slideTargets.length;
    });
  }

  startInterval() {
    this.interval = setInterval(() => {
      this.indexValue++;
      this.showSlide();
    }, 10000);
  }

  resetInterval() {
    clearInterval(this.interval);
    this.startInterval();
  }
}
