import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

export default class extends Controller {
  static targets = [ "hiddenContent" ];

  change(event) {
    let selectedOptionId = event.target.selectedOptions[0].value;

    get(`/students
  }
}
