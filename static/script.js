const input = document.querySelector(".finder__input");
const finder = document.querySelector(".finder");
const form = document.querySelector("form");

input.addEventListener("focus", () => {
  finder.classList.add("active");
});

input.addEventListener("blur", () => {
  if (input.value.length === 0) {
    finder.classList.remove("active");
  }
});

form.addEventListener("text", (ev) => {
  finder.classList.add("processing");
  finder.classList.remove("active");
  setTimeout(() => {
    finder.classList.remove("processing");
    if (input.value.length > 0) {
      finder.classList.add("active");
    }
  }, 1000);
  console.log(ev);
});