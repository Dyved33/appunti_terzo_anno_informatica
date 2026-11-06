let track;
let slides;
let slideWidth;
let index = 0;
let margin = 32;

const mediaQuery = window.matchMedia("(max-width: 600px)");

window.addEventListener("load", function () {
    track = document.getElementById("slideshow-track");
    slides = document.getElementsByClassName("slide");

    document.getElementById("slideshow-container").addEventListener("click", move);
    setInterval(move, 9000);
})

function move() {
    margin = mediaQuery.matches ? 0 : 32;
    slideWidth = slides[0].offsetWidth + margin;
    index = (index + 1) % (slides.length - 1);
    const offset = -(index * slideWidth);
    track.style.transform = "translateX(" + offset + "px)";
}