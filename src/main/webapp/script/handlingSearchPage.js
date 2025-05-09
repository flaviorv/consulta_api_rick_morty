document.addEventListener("DOMContentLoaded", () => {
    const nav = document.getElementById("nav");
    const input = document.getElementById("search-input");
    const searchForm = document.getElementById("search-form")
    const tableDiv = document.getElementById("table-div");
    const table = document.getElementById("table");
    const searchDiv = document.getElementsByClassName("search-div");
    const body = document.getElementById("body")
    const closeBtn = document.getElementById("close-btn")
    const searchBtn = document.getElementById("search-btn")

    if (input) {
        input.addEventListener("keydown", (event) => {
            if (event.key === "Enter") {
                event.preventDefault();
                findCharacters(input.value);
            }
        })

        input.addEventListener("focus", () => {
            nav.classList.add("remove-nav");
            searchForm.classList.add("search-form-to-top")
            table.classList.add("remove-table")
            tableDiv.classList.add("remove-table")
            for (let sd of searchDiv) {
                sd.classList.add("search-div-appearing");
            }
            body.classList.add("body-on-search")
            searchBtn.classList.add("search-btns")
            closeBtn.classList.add("search-btns")
            input.style.transform = "scale(1.2)"

        });
    }

    if (closeBtn) {
        closeBtn.addEventListener("click", () => {
            nav.classList.remove("remove-nav");
            searchForm.classList.remove("search-form-to-top")
            table.classList.remove("remove-table")
            tableDiv.classList.remove("remove-table")
            for (let sd of searchDiv) {
                sd.classList.remove("search-div-appearing")
            }
            body.classList.remove("body-on-search")
            searchBtn.classList.remove("search-btns")
            closeBtn.classList.remove("search-btns")
            input.style.transform = "scale(1)"
            input.value = ""
        });
    }


    if (searchBtn) {
        searchBtn.addEventListener("click", () => {
            findCharacters(input.value)
        })
    }

});