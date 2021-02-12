// Add shadow on scroll
$(window).on('load scroll', (e) => {
  const navbar = $("#GlobalNav");
  if (window.pageYOffset > 0) {
    navbar.addClass("nav--scrolled");
  } else {
    navbar.removeClass("nav--scrolled");
  }
})