$(document).on('turbolinks:load', function() {
  $(".edit_track").hide(); // hide PaperClip buttons

  if ($(".new-sampler-container").length > 0) {
    $(".paperclip-preview").on("click", handleImageUpload)
  }
})

let handleImageUpload = function() {
  var selectFileButton = $(this).siblings().find("input")[3]
  var updateFileButton = $(this).siblings().find("input")[4]
  $(selectFileButton).trigger( "click" );
  $(selectFileButton).change(function(){
    $(updateFileButton).trigger( "click" );
  })
}