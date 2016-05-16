document.addEventListener("turbolinks:load", function() {
  $(function () {
    $('[data-toggle="popover"]').popover({ trigger: "hover" })
  })
});