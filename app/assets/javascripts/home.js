document.addEventListener("turbolinks:load", function() {
  $("#play-button").click(function() {
    $(this).addClass("activated");
  });
});