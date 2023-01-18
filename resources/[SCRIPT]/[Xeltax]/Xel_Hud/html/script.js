let hud = document.querySelector(".hud-container")
let job = document.querySelector(".hud-container > .job-container > .job-card:first-child > p")
let job2 = document.querySelector(".hud-container > .job-container > .job-card:last-child > p")
let money = document.querySelector(".money-container > .money-card:first-child > p")
let bank = document.querySelector(".money-container > .money-card:nth-child(2) > p")
let black_money = document.querySelector(".money-container > .money-card:last-child > p")

let societyText = document.querySelector(".society-container > .society-card:first-child > p")
let society2Text = document.querySelector(".society-container > .society-card:last-child > p")
let society = document.querySelector(".society-container > .society-card:first-child")
let society2 = document.querySelector(".society-container > .society-card:last-child")

society.style.display = "none";
society2.style.display = "none";

function hudLoaded() {
    hud.style.display = "block";
}

window.addEventListener('message', (event) => {

    if (event.data.loaded === true) {
        hudLoaded()
    }

    if (event.data.job) {
        job.animate([{ opacity : "0"}, {opacity : "1"}], {duration: 1000, fill: "forwards"});
        job.innerText = event.data.job.label + " - " + event.data.job.grade_label;
    }

    if (event.data.job2) {
        job2.animate([{ opacity : "0"}, {opacity : "1"}], {duration: 1000, fill: "forwards"});
        job2.textContent = event.data.job2.label + " - " + event.data.job2.grade_label;
    }

    if (event.data.money) {
        money.animate([{ opacity : "0"}, {opacity : "1"}], {duration: 1000, fill: "forwards"});
        money.textContent = event.data.money.toString().split(/(?=(?:...)*$)/).join(" ");
    }

    if (event.data.bank) {
        bank.animate([{ opacity : "0"}, {opacity : "1"}], {duration: 1000, fill: "forwards"});
        bank.textContent = event.data.bank.toString().split(/(?=(?:...)*$)/).join(" ");
    }

    if (event.data.black_money != null) {
        black_money.animate([{ opacity : "0"}, {opacity : "1"}], {duration: 1000, fill: "forwards"});
        black_money.textContent = event.data.black_money.toString().split(/(?=(?:...)*$)/).join(" ");
    }

    if (event.data.society) {
        if (event.data.job.grade_name === "boss") {
            society.style.display = "flex";
            societyText.animate([{ opacity : "0"}, {opacity : "1"}], {duration: 1000, fill: "forwards"});
            societyText.textContent = event.data.society;
        } else {
            society.style.display = "none";
        }
    }

    if (event.data.society2) {
        if (event.data.job2.grade_name === "boss") {
            society2.style.display = "flex";
            society2Text.animate([{ opacity : "0"}, {opacity : "1"}], {duration: 1000, fill: "forwards"});
            society2Text.textContent = event.data.society2;
        } else {
            society2.style.display = "none";
        }
    }
});