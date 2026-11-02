let track;
let slides;
let slideWidth;
let index = 0;
let margin = 32;

// Valuto la media query CSS
const mediaQuery = window.matchMedia("(max-width: 600px)");

window.addEventListener("load", function() {

    // Seleziono gli elementi dello slideshow
    track = document.getElementById("slideshow-track");
    slides = document.getElementsByClassName("slide");

    // Click per far avanzare le slide
    document.getElementById("slideshow-container").addEventListener("click", move);

    // Avanzamento automatico
    setInterval(move, 9000);

});


/*
 * Funzione che muove la slideshow in avanti
 */
function move() {

    // Imposto il margine in base alla dimensione dello schermo
    margin = mediaQuery.matches ? 0 : 32;

    // Calcolo la larghezza delle slides considerando il margine
    slideWidth = slides[0].offsetWidth + margin;

    // Aggiorno l'indice ciclando tra le slide
    index = (index + 1) % (slides.length - 1);

    // Calcolo lo spostamento orizzontale da applicare
    const offset = -(index * slideWidth);

    // Applico la trasformazione per spostare le slide
    track.style.transform = `translateX(${offset}px)`;

}
