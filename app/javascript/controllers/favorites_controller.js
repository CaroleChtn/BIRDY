import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.token = document.querySelector("meta[name=csrf-token]").content
  }

  fav(evt) {
    fetch(`/missions/${evt.params.missionId}/favorites`, {
      method: "POST",
      headers: { "Accept": "application/json", "X-CSRF-TOKEN": this.token }
    })
      .then(response => response.json())
      .then((data) => {
        if (data.unfav) {
          evt.target.style.color = "black";
        } else {
          evt.target.style.color = "red";
        }
      })
    }
}
