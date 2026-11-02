window.addEventListener("load", function() {
    
    // Seleziono tutte le immagini
    const imgs = document.querySelectorAll("#tab .cell img");

    // Aggiungo un listener per il movimento del mouse su ogni immagine
    imgs.forEach(im => {
        im.addEventListener('mousemove', function(event) {
            //console.log(event)

            // Ottengo la larghezza dell'immagine
            const imageWidth = im.offsetWidth;
        
            // Ottenzo la posizione orizzontale del mouse rispetto all'immagine
            const mouseX = event.offsetX;

            // Calcolo il valore del filtro (tra 0 e 120)
            const filtro = (mouseX / imageWidth) * 120;
        
            // Applico il filtro all'immagine corrente
            im.style.filter = `hue-rotate(${filtro}deg)`;
        });
    });

});
