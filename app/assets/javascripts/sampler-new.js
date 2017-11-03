$(document).on('turbolinks:load', function() {
  $(".edit_track").hide();
  if ($(".new-sampler-container").length > 0) {

    $(".paperclip-preview").on("click", function() {
      var selectFile = $(this).siblings().find("input")[3]
      var updateFile = $(this).siblings().find("input")[4]
      $(selectFile).trigger( "click" );
      $(selectFile).change(function(){
        $(updateFile).trigger( "click" );
      })
    })
  }
})
