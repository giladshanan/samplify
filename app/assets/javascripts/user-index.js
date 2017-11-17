$(document).on('turbolinks:load', function() {
  $("#spotify-logo").on("click", function() {
    $("a")[0].click();
    console.log(request.user_agent)
  })
})
