
var ready;
ready = function() {
  document.getElementById("bgvid").defaultPlaybackRate = 1;
  document.getElementById("bgvid").load();
};

$(document).ready(ready);
$(document).on('page:load', ready);
