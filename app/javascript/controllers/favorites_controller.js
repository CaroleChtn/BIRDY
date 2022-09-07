import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.token = document.querySelector("meta[name=csrf-token]").content
  }

  fav(evt) {
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
        if (data.unfav) {
          console.log(1)
          if (data.page === "/dashboards") {
            evt.target.closest('.card-index').remove();
          } else {
            console.log(2)
            evt.target.style.color = "black";
          }
        } else {
          console.log(3)
          evt.target.style.color = "red";
          const heart = document.querySelector('#top-heart')
          heart.style.color = 'red';
        }
      })
    }
}
