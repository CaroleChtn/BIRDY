import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
static targets = ["item", "short"]

  connect() {
 console.log("test")
  }

  toggle(event) {
    console.log("click")
    this.itemTarget.classList.toggle("d-none")
    this.shortTarget.classList.toggle("d-none")
    if (event.currentTarget.innerText === "Voir plus !"){
      event.currentTarget.innerText = "Voir moins"
    }
    else {
      event.currentTarget.innerText = "Voir plus !"
    }
  }
}
