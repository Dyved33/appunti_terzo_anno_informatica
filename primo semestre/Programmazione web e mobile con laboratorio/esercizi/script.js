/*function somma(a, b) {
    let s = a + b;
    console.log(s);
}

function somma(a, b) {
    let s = a + b;
    console.log(s);
    window.alert(s);
}

function somma(a, b) {
    let s = a + b;
    console.log(s);
    window.alert(s)
    document.getElementById("ris").innerHTML = s;
}*/

function provaSelezione() {
    const parByTagName = document.getElementsByTagName("p");
    const parQuerySelector = document.querySelectorAll("p");
    console.log("Prima - getElementsByTagName:", parByTagName);
    console.log("Prima - querySelectorAll:", parQuerySelector);

    const newP = document.createElement("p");
    newP.textContent = "Ciao, sono un altro paragrafo!";
    document.body.appendChild(newP);
    console.log("Dopo - getElementsByTagName:", parByTagName);
    console.log("Dopo - querySelectorAll:", parQuerySelector);
}