window.addEventListener("load", function() {

    // Seleziono tutti gli oggetti da animare allo scorrimento
    // Ho bisogno di un array per poterlo modificare
    let enterElements = Array.from(document.querySelectorAll(".enter-a, .enter-b"));

    // Controllo al caricamento della pagina se ci sono già elementi visibili
    checkPosition(enterElements);

    // Aggiungo un listener per scroll
    window.addEventListener("scroll", function() {
            checkPosition(enterElements);
    });

});


/*
* Funzione per controllare la posizione degli elementi
*/
function checkPosition(enterElements) {

    // Imposto una soglia
    const soglia = window.innerHeight * 0.6;

    enterElements.forEach((item, index) => {

        // Calcolo la distanza dell'elemento dal top della finestra
        const rectTop = item.getBoundingClientRect().top;

        if (rectTop < soglia) {
            item.classList.add("entered");
            //console.log(rectTop, soglia, window.innerHeight);

            // Rimuovo l'elemento dall'array
            enterElements.splice(index, 1);
        }

    });

}
