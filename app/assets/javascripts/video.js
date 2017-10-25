$(document).on('turbolinks:load', function() {
  var tar_coord_x = $(".slideshow-container").offset().left;
  var tar_coord_y = $(".slideshow-container").offset().top;
  console.log($(".slideshow-container").offset())
  if (window.location.href.search(/(samplers\/\d+)/) > 0) {
    $(".mySlides").hide()
    $(".mySlides").first().show()
    var audioController = $("audio")[0]
    audioController.volume = 0.35
    var imageIndex = 0
    var slideIndex = 0
    thumbToOriginal(tar_coord_x, tar_coord_y, imageIndex);
    $(".thumbs").on("click", function(event){
      audioController.volume = 0.35
      audioController.currentTime = ($(this).parent().index()) * 30
      console.log(audioController.currentTime)
      if (audioController.paused){
        $("#play").trigger( "click" );
      }
      // if ($(".thumbs").first().hasClass('start')) {
      //   $(".thumbs").first().removeClass("start")
      //   $(".thumbs").first().addClass("grow")
      // }
      // slideIndex = Math.floor(audioController.currentTime/30)
      // imageIndex = slideIndex * 2
      // $(".thumbs").css("opacity", 1)
      // $(".thumbs").eq(imageIndex).css( "opacity", 0.33 )
      // $(".mySlides").hide()
      // $(".mySlides").eq(imageIndex).attr("style", "display:block")
      // thumbToOriginal(tar_coord_x, tar_coord_y, imageIndex);
    })
    var count = 1
    $("#play").on("click", function(event) {
      if (audioController.paused){
        audioController.play();
      } else {
        audioController.pause();
      }
      var playCount = count
      setInterval(function() {
        if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 1 && playCount === 1) {
          audioController.volume /= 0.7
        }
        if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 2 && playCount === 1) {
          audioController.volume /= 0.7
        }
        if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 3 && playCount === 1) {
          audioController.volume = 1
        }
        if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 28 && playCount === 1) {
          audioController.volume *= 0.7
        }
        if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 29 && playCount === 1) {
          audioController.volume *= 0.7
        }
        if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 0 && playCount === 1) {
          if (audioController.volume > 0.4) {
            audioController.volume *= 0.7
          }
          if ($(".thumbs").first().hasClass('start')) {
            $(".thumbs").first().removeClass("start")
            $(".thumbs").first().addClass("grow")
          }
          console.log("start")
          console.log(audioController.currentTime)
          var startingIndex = imageIndex
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
      }, 1000)
      count += 1
    })
    // var downloadChecker = setInterval(function(){
    //   var audioSource = $("audio").attr("src");
    //   var samplerID = /\d+(?=.mp3)/g.exec(audioSource);
    //   var url = "/samplers/check/" + samplerID
    //   var request = $.ajax({
    //     url: url
    //   });
    //   request.done(function(response) {
    //     $(".download-link").html("")
    //     $(".download-link").append(response)
    //     clearInterval(downloadChecker);
    //   });
    // }, 5000)
  }
})

function thumbToOriginal(tar_coord_x, tar_coord_y, imageIndex = 0) {
  var this_coord_x = $(".thumbs").eq(imageIndex).offset().left;
  var this_coord_y = $(".thumbs").eq(imageIndex).offset().top;
  console.log("this: ", this_coord_x, this_coord_y)
  var move_coord_x = tar_coord_x - this_coord_x;
  var move_coord_y = tar_coord_y - this_coord_y;
  console.log("move: ", move_coord_x, move_coord_y)
  $(".thumbs").eq(imageIndex).css("transform", "translate(" + move_coord_x + "px, " + move_coord_y + "px) scale(10)");
}

function originalToThumb(imageIndex) {
  $(".thumbs").eq(imageIndex).css("transform", "");
}
