import { Controller } from '@hotwired/stimulus';
export default class extends Controller {
  static targets = ['preview', 'input', 'x'];

  show() {
    const image = this.inputTarget.files[0];
    this.previewTarget.src = URL.createObjectURL(image);
    this.previewTarget.alt = image.name;
    this.xTarget.style.opacity = '1';
  }

  remove() {
    this.previewTarget.src = '';
    this.previewTarget.alt = '';
    this.inputTarget.value = '';
    this.xTarget.style.opacity = '0';
  }
}
