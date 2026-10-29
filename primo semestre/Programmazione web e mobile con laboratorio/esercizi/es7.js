function aggiungi() {
    const testo = document.getElementById("testo").value;
    const col = document.getElementById("colore").value;

    const p = document.createElement("p");
    p.textContent = testo;
    p.style.color = col;

    document.body.append(p);
}

function ciclo(){
    
}