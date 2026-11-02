window.addEventListener("load", function() {
  
    document.getElementById("form1").addEventListener("submit", function(event) {

        // Disattivo il redirect di default
        event.preventDefault();

        // Leggo l'input
        const nome = document.getElementById("nome").value;
        const cognome = document.getElementById("cognome").value;
        const stile = document.getElementById("stile").value;
        const anno = document.getElementById("anno").value;

        // Creo la riga per la tabella
        const table = document.querySelector("#tab1 tbody");
        const newRow = document.createElement("tr");

        // Crea e aggiunge le celle con i contenuti
        const cell1 = document.createElement("td");
        cell1.textContent = nome;
        newRow.appendChild(cell1);

        const cell2 = document.createElement("td");
        cell2.textContent = cognome;
        newRow.appendChild(cell2);

        const cell3 = document.createElement("td");
        cell3.textContent = stile;
        newRow.appendChild(cell3);

        const cell4 = document.createElement("td");
        cell4.textContent = anno;
        newRow.appendChild(cell4);

        // Aggiungo la riga alla tabella
        table.appendChild(newRow);

        // Faccio scroll alla nuova riga
        newRow.scrollIntoView({ behavior: "smooth" });

        // Svuoto la form
        document.getElementById("form1").reset();

    });

});
