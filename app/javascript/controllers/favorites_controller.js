import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['counter']

  connect() {
    this.token = document.querySelector("meta[name=csrf-token]").content
    this.favCounter = document.querySelector("#fav-counter")
  }

  fav(evt) {
    console.log("lààààààà")
    fetch(`/missions/${evt.params.missionId}/favorites`, {
      method: "POST",
      headers: {
        "content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-TOKEN": this.token },
      body: JSON.stringify({ page: window.location.pathname })
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
        if (data.unfav) {
          this.favCounter.innerText = Number.parseInt(this.favCounter.innerText, 10) - 1
          console.log('HERE', Number.parseInt(this.favCounter.innerText, 10))

          if (Number.parseInt(this.favCounter.innerText) === 0) {
            this.favCounter.innerText = 0
            this.favCounter.classList.add("d-none")
          }

          if (data.page === "/dashboards") {
            evt.target.closest('.card-index').remove();
          } else {
            evt.target.style.color = "black";
          }

        } else {
          this.favCounter.innerText = Number.parseInt(this.favCounter.innerText, 10) + 1
          evt.target.style.color = "red";
          this.favCounter.classList.remove('d-none')
        }
      })
    }
}
