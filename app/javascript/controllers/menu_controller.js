import { Controller } from '@hotwired/stimulus';
export default class extends Controller {
  static targets = ['menu', 'text'];

  toggle() {
    if (
      getComputedStyle(this.menuTarget).transform ==
      'matrix(1, 0, 0, 0, 0, 0)'
    ) {
      this.menuTarget.style.transform = 'scaleY(1)';
      this.textTargets.forEach(
        (target) => (target.style.opacity = '100%')
      );
    } else {
      this.menuTarget.style.transform = 'scaleY(0)';
      this.textTargets.forEach(
        (target) => (target.style.opacity = '0')
      );
    }
  }
}
