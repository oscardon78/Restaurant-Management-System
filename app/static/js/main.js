/* ========== Navigation =========== */
const hamburger = document.querySelector(".hamburger");
const close = document.querySelector(".nav-list .close");
const menu = document.querySelector(".nav-list");

hamburger.addEventListener("click", () => {
  menu.classList.add("show");
});

close.addEventListener("click", () => {
  menu.classList.remove("show");
});

/* ========== SignIn Form =========== */
const signInForm = document.querySelector("header .wrapper");

document.querySelector(".signin").onclick = () => {
  signInForm.classList.add("active");
};

document.querySelector(".close-form").onclick = () => {
  signInForm.classList.remove("active");
};

/* ========== Order Unsuccessful =========== */

// document.querySelector(".checkout-form").onclick = () => {
  //   orderForm.classList.add("active");
  // };
  const orderForm = document.querySelector(".pop-up .wrapper2");

document.querySelector(".close-form1").onclick = () => {
  orderForm.classList.remove("active");};

document.querySelector(".close-mod").onclick = () => {
  event.stopPropagation();
  orderForm.classList.remove("active");
};
