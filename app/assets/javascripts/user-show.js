$(document).on('turbolinks:load', function() {
  $(".playlist-button").on("click", function(event) {
    if ($(".page-content-right").is(":visible")) {
      toggleView();
    };
  });
  $(".sampler-button").on("click", function(event) {
    if ($(".page-content-left").is(":visible")) {
      toggleView();
    };
  });
});

var toggleView = function() {
  $(".playlist-button").toggleClass("pressed");
  $(".sampler-button").toggleClass("pressed");
  $(".page-content-left").toggle();
  $(".page-content-right").toggle();
}
