window.addEventListener("load", function () {
    const imgs = document.querySelectorAll(".cell img")

    imgs.forEach(element => {
        element.addEventListener("mousemove", function (event) {
            const mouseX = event.offsetX;
            const imageWidth = element.offsetWidth;

            const filtro = (mouseX / imageWidth) * 120;

            console.log("larghezza immagine: " + imageWidth);
            console.log("offset mouse: " + mouseX);
            console.log("proporzione: " + filtro);
            console.log("hue: " + element.style.filter);

            element.style.filter = `hue-rotate(${filtro}deg)`;
        })
    });
})