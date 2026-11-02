window.addEventListener("load", function () {
    let enterElements = Array.from(document.querySelectorAll(".enter-a, .enter-b"));

    window.addEventListener("scroll", function () {
        const soglia = window.innerHeight * 0.6;

        enterElements.forEach(element => {
            const rectTop = element.getBoundingClientRect().top;
            if (rectTop < soglia) {
                element.classList.add("entered");
            }
        });
    })
})