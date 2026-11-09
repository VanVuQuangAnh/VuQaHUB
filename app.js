const form = document.querySelector("#search-form");
const input = document.querySelector("#search-input");
const clearButton = document.querySelector("#clear-button");

function updateClearButton() {
  clearButton.hidden = !input.value;
}

input.addEventListener("input", updateClearButton);

clearButton.addEventListener("click", () => {
  input.value = "";
  updateClearButton();
  input.focus();
});

document.querySelectorAll(".suggestion").forEach((suggestion) => {
  suggestion.addEventListener("click", () => {
    input.value = suggestion.dataset.query;
    form.requestSubmit();
  });
});
