window.addEventListener("load", function () {
    document.getElementById("form1").addEventListener("submit", function (e) {
        const nome = document.getElementById("nome").value;
        const cognome = document.getElementById("cognome").value;
        const stile = document.getElementById("stile").value;
        const anno = document.getElementById("anno").value;

        const table = document.getElementById("tab1");

        const newRow = document.createElement("tr");

        const cell1 = document.createElement("td");
        cell1.textContent = nome;
        newRow.appendChild(cell1);

        const cell2 = document.createElement("td");
        cell1.textContent = nome;
        newRow.appendChild(cell2);

        const cell3 = document.createElement("td");
        cell1.textContent = nome;
        newRow.appendChild(cell3);

        const cell4 = document.createElement("td");
        cell1.textContent = nome;
        newRow.appendChild(cell4);

        table.appendChild(newRow);

        this.scrollIntoView({ behavior: "smooth" });
    });
});