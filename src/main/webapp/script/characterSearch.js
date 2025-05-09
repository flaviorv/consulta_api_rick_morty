let characterName = document.querySelector(".found-name")
let characterStatus = document.querySelector(".found-status")
let characterSpecie = document.querySelector(".found-species")
let characterType = document.querySelector(".found-type")
let characterGender = document.querySelector(".found-gender")
let characterOrigin = document.querySelector(".found-origin")
let characterLocation = document.querySelector(".found-location")
let characterCreated = document.querySelector(".found-created")
let characterImg = document.querySelector(".found-img")
let foundAttributes = document.getElementsByClassName("character-attribute")
let searchDiv = document.getElementsByClassName("search-div")
let nextIcon = document.querySelector(".next-icon")
let lastCloneElement = null;

function wait(ms) {
    return new Promise(resolve => setTimeout(resolve, ms))
}

async function findCharacters(name) {
    clearSearch()

    const res = await fetch("https://rickandmortyapi.com/api/character/?page=1", {method: 'GET'})
    const data = await res.json();

    await compareCharacters(name, data.results)

    pages = data.info.pages
    for (let i = 2 ; i <= pages; i++) {
        const res = await fetch("https://rickandmortyapi.com/api/character/?page="+i, {method: 'GET'})
        const data = await res.json();
        await compareCharacters(name, data.results)
    }
    clearNotFoundElement(name)

    if (searchDiv.length > 1) {
        addClickNext()
    }
}

async function compareCharacters(name, characters) {
    for (let i = 0; i < foundAttributes.length; i++) {
        foundAttributes[i].style.backgroundColor = "white";
    }
    for (let character of characters) {
        await wait(25)
        characterName.innerHTML = "Name: " + character.name
        characterStatus.innerHTML = "Status: " + character.status
        characterSpecie.innerHTML = "Specie: " + character.species
        characterType.innerHTML = "Type: " + character.type
        characterGender.innerHTML = "Gender: " + character.gender
        characterOrigin.innerHTML = "Origin: " + character.origin.name
        characterLocation.innerHTML = "Location: " + character.location.name
        characterCreated.innerHTML = "Created: " + character.created
        characterImg.src = character.image
        if (name != '' && character.name.startsWith(name)) {
            lastCloneElement = clone()
        }
    }
}

function clone() {
    let old = searchDiv[0]
    let newElement = old.cloneNode(true);
    old.classList.remove("search-div-appearing")
    changeElementsTo(newElement)
    document.body.appendChild(newElement)
    return newElement
}

function changeElementsTo(element) {
    characterName = element.querySelector(".found-name")
    characterImg = element.querySelector(".found-img")
    characterType = element.querySelector(".found-type")
    characterGender = element.querySelector(".found-gender")
    characterLocation = element.querySelector(".found-location")
    characterOrigin = element.querySelector(".found-origin")
    characterSpecie = element.querySelector(".found-species")
    characterStatus = element.querySelector(".found-status")
    characterCreated = element.querySelector(".found-created")
    nextIcon = element.querySelector(".next-icon")
}

function clearNotFoundElement(name) {
    if (searchDiv.length > 1) {
        for (let sd of searchDiv) {
            console.log(sd.querySelector(".found-name").innerHTML.replace("Name: ", ""))
            if(sd !== null &&
                !sd.querySelector(".found-name").innerHTML.replace("Name: ", "").startsWith(name)) {
                sd.remove()
                console.log("removing last", searchDiv.length)

            }
        }
        searchDiv[0].classList.add("search-div-appearing")

    } else {
        console.log(characterName.innerHTML.replace("Name: ", ""), name)
        if (name === "" || !characterName.innerHTML.replace("Name: ", "").startsWith(name)) {
            console.log("erase")
            eraseFields()
        }
    }
}

function clearSearch() {
    for (let i = 0; i < searchDiv.length ; i++) {
        if (i !== 0) {
            console.log(i, "cleaning")
            searchDiv[i].remove()
        }
    }
    changeElementsTo(searchDiv[0])
    eraseFields()
    searchDiv[0].classList.add("search-div-appearing")
}

function eraseFields() {
    console.log("erasing")
    characterName.innerHTML = ""
    characterStatus.innerHTML = ""
    characterSpecie.innerHTML = ""
    characterType.innerHTML = ""
    characterGender.innerHTML = ""
    characterOrigin.innerHTML = ""
    characterLocation.innerHTML = ""
    characterCreated.innerHTML = ""
    characterImg.src = "../image/no_profile.png"
    nextIcon.removeEventListener("click", switchToNext)
    nextIcon.classList.remove("show-next")
}

function addClickNext() {
    for (let element of searchDiv) {
        let next = element.querySelector(".next-icon")
        next.addEventListener("click", switchToNext)
        next.classList.add("show-next")
    }
}

async function switchToNext() {
    await wait(1000)
    const elements = Array.from(searchDiv)
    let currentIndex = elements.findIndex(el => {
        return window.getComputedStyle(el).display !== "none"
    })
    elements[currentIndex].classList.remove("search-div-appearing")
    const nextIndex = (currentIndex + 1) % elements.length
    elements[nextIndex].classList.add("search-div-appearing")
    changeElementsTo(elements[nextIndex])
}

