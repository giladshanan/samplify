$(document).on('turbolinks:load', function() {
  if (window.location.href.search(/(samplers\/\d+)/) > 0) {
    $("#pause").hide()
    $(".mySlides").hide()
    $(".mySlides").first().show()

    var tar_coord_x = $(".slideshow-container").offset().left;
    var tar_coord_y = $(".slideshow-container").offset().top;
    var imageIndex = 0
    var slideIndex = 0
    var playClickCount = 1
    var audioController = $("audio")[0]
    var startingVolume = 0.35
    audioController.volume = startingVolume

    thumbToOriginal(tar_coord_x, tar_coord_y, imageIndex);
    $(".thumbs").eq(imageIndex+1).css( "opacity", 0.33 )

    $(".thumbs").on("click", function(event){
      audioController.volume = startingVolume
      audioController.currentTime = ($(this).parent().index()) * 30
      if (audioController.paused){
        $("#play").trigger( "click" );
      }
    })

    $("#play-buttons").on("click", function(event) {
      if (audioController.paused){
        audioController.play();
        $("#pause").toggle()
        $("#play").toggle()
      } else {
        audioController.pause();
        $("#play").toggle()
        $("#pause").toggle()
      }
    })
      // ideas= ["named functions", "a method that takes in current time and returns the vol multiplier", "better solution for click counter"]
    $("#play-buttons").one("click", function(event) {

      var playCount = playClickCount

      setInterval(function() {
        var currentTrackTime = Math.floor(audioController.currentTime) % 30
        if (audioController.paused === false && playCount === 1) {
          if (currentTrackTime === 1 || currentTrackTime === 2 || currentTrackTime === 3 ) {
            audioController.volume /= 0.85
            console.log(audioController.volume)
          }
          if ((currentTrackTime === 28 || currentTrackTime === 29 || currentTrackTime === 0) && (audioController.volume > 0.4) ) {
            audioController.volume *= 0.85
            console.log(audioController.volume)
          }
        }
      playClickCount += 1
      }, 500)

      setInterval(function() {
        var trackTime = Math.floor(audioController.currentTime) % 30

        if (audioController.paused === false && (trackTime) === 0 && playCount === 1) {
          if ($(".thumbs").first().hasClass('start')) {
            $(".thumbs").first().removeClass("start")
            $(".thumbs").first().addClass("grow")
          }
          var startingIndex = slideIndex
          if (startingIndex != Math.floor(audioController.currentTime/30)) {
            originalToThumb(imageIndex);
            slideIndex = Math.floor(audioController.currentTime/30)
            imageIndex = slideIndex * 2
            $(".thumbs").css("opacity", 1)
            $(".thumbs").eq(imageIndex+1).css( "opacity", 0.33 )
            $(".mySlides").hide()
            $(".mySlides").eq(slideIndex).attr("style", "display:block")
            thumbToOriginal(tar_coord_x, tar_coord_y, imageIndex);
          }
        }
      playClickCount += 1
      }, 1000)

    })

    var downloadChecker = setInterval(function(){
      var audioSource = $("audio").attr("src");
      var samplerID = /\d+(?=.mp3)/g.exec(audioSource);
      var url = "/samplers/check/" + samplerID
      var request = $.ajax({
        url: url
      });
      request.done(function(response) {
        $(".download-link").html("")
        $(".download-link").append(response)
      });
    }, 5000)
  } else {
    for (var i = 1; i < 9999; i++) {
      window.clearInterval(i)
    }
    $("#spotify-logo").on("click", function() {
      $("a")[0].click();
    })
  }
})

function thumbToOriginal(tar_coord_x, tar_coord_y, imageIndex) {
  var this_coord_x = $(".thumbs").eq(imageIndex).offset().left;
  var this_coord_y = $(".thumbs").eq(imageIndex).offset().top;
  var move_coord_x = tar_coord_x - this_coord_x;
  var move_coord_y = tar_coord_y - this_coord_y;
  $(".thumbs").eq(imageIndex).css("transform", "translate(" + move_coord_x + "px, " + move_coord_y + "px) scale(10)");
}

function originalToThumb(imageIndex) {
  $(".thumbs").eq(imageIndex).css("transform", "");
}
