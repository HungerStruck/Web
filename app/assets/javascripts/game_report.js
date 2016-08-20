(function() {
  $(document).on('turbolinks:load', function() {
    var slide = 1
    window.setInterval(function(){
      if(slide == 1) {
        $('#view-1').css('opacity', '0.0');
        $('#view-2').css('opacity', '0.6');
        slide++
      } else if(slide == 2) {
        $('#view-2').css('opacity', '0.0');
        $('#view-3').css('opacity', '0.6');
        slide++
      } else {
        $('#view-3').css('opacity', '0.0');
        $('#view-1').css('opacity', '0.6');
        slide = 1
      }
    }, 15000);
  });
}).call(this);