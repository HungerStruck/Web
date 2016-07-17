document.addEventListener("turbolinks:load", function() {
  var fadedPosts = false;
  $('[data-reply]').on( "click", function() {
    var quoted = $(this).attr('data-reply');
    if ( $( "#" + quoted ).length ) {
      var scrollduration = (window.scrollY - $( "#" + quoted ).offset().top);
      if(scrollduration < 0) {
        scrollduration = scrollduration * -1;
      }
      scrollduration = Math.sqrt(scrollduration) * 20;
      $( ".post:not(#" + quoted +")").css('opacity', '0.3')
      $( "#" + quoted).css('transform', 'scale(1.05)');
      $('html, body').animate({
          scrollTop: ($( "#" + quoted ).offset().top - 50)
      }, {
        duration: scrollduration,
        complete: function() {
          fadedPosts = true;
          setTimeout(function(){ $( ".post").css('opacity', '1').css('transform', 'scale(1)'); }, 500);
        }
      });
    } else {
      $( this ).parent().find(".reply-quote").show();
    }
  });

});
