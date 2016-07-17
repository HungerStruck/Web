document.addEventListener("turbolinks:load", function() {
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

      var docViewTop = $(window).scrollTop();
      var docViewBottom = docViewTop + $(window).height();

      var elemTop = $(this).parent().offset().top;
      var elemBottom = elemTop + $(this).parent().height();

      if((elemBottom <= docViewBottom) && (elemTop >= docViewTop)) {
        setTimeout(function(){ $( ".post").css('opacity', '1').css('transform', 'scale(1)'); }, 500);
      } else {
        $('html, body').animate({
            scrollTop: ($( "#" + quoted ).offset().top - 50)
        }, {
          duration: scrollduration,
          complete: function() {
            setTimeout(function(){ $( ".post").css('opacity', '1').css('transform', 'scale(1)'); }, 500);
          }
        });
      }
    } else {
      $( this ).parent().find(".reply-quote").show();
    }
  });

});