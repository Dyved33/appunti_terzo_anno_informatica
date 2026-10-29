function accendiLuce() {
    document.getElementById("luce-img").src = "immagini/luce-on.png";
}

function somma(a, b) {
    let r = a + b;
    console.log(r);
    window.alert(r);
    document.getElementById("risualtato-somma").innerHTML = r;
}

function provaSelezione() {

    const mioDiv = document.getElementById("prova-sel");
    const parByTagName = mioDiv.getElementsByTagName("p");
    const parQuerySelector = mioDiv.querySelectorAll("p");

    console.log("Prima - getElementsByTagName:", parByTagName.length, parByTagName);
    console.log("Prima - querySelectorAll:", parQuerySelector.length, parQuerySelector);
    
    const newP = document.createElement("p");
    newP.textContent = "Ciao, sono un altro paragrafo!";
    mioDiv.appendChild(newP);

    console.log("Dopo - getElementsByTagName:", parByTagName.length, parByTagName);
    console.log("Dopo - querySelectorAll:", parQuerySelector.length, parQuerySelector);
}

function cambiaTesto() {
    const elemento = document.getElementById("testoA");
    console.log("Testo prima:", elemento.textContent);
    elemento.textContent = "La bella addormentata";
    console.log("Testo dopo:", elemento.textContent);
}

function cambiaImmagine() {
    const img = document.getElementById("paese");
    img.setAttribute("src", "immagini/imm2.jpg");
}


function sostituisciClasse() {
    const elemento = document.getElementById("bello1");
    elemento.className = "bott-bello-bis";
}

function toggleClasse() {
    const elemento = document.getElementById("bello2");
    elemento.classList.toggle("bott-bello-bis");
}