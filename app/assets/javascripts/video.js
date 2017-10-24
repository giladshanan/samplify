$(document).ready(function() {
  $(".mySlides").hide()
  $(".mySlides").first().show()
  var audioController = $("audio")[0]
  var musicPlaying = false
  $(".thumbs").on("click", function(event){
    audioController.currentTime = ($(this).index()) * 30
    audioController.play();
  })
  var count = 1
  $("#play").on("click", function(event) {
    if(audioController.paused){
      audioController.play();
    } else {
      audioController.pause();
    }

    var playCount = count
    console.log(audioController);
    var imageIndex = 0
    //audioController.volume = 0.35
    console.log("start: " + audioController.volume)
    window.setInterval(function() {
      if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 1 && playCount === 1) {
        audioController.volume /= 0.7
        console.log("sec 1: " + audioController.volume)
      }
      if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 2 && playCount === 1) {
        audioController.volume /= 0.7
        console.log("sec 2: " + audioController.volume)
      }
      if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 3 && playCount === 1) {
        audioController.volume = 1
        console.log("sec 3: " + audioController.volume)
      }
      if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 28 && playCount === 1) {
        audioController.volume *= 0.7
        console.log("sec 28: " + audioController.volume)
      }
      if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 29 && playCount === 1) {
        audioController.volume *= 0.7
        console.log("sec 29: " + audioController.volume)
      }
    if ($("audio").get(0).paused === false && (Math.floor(audioController.currentTime) % 30 ) === 0 && playCount === 1) {
        if (audioController.volume > 0.4) {
          audioController.volume *= 0.7
        }
        console.log("sec 0: " + audioController.volume)
        imageIndex = Math.floor(audioController.currentTime/30)
        $(".mySlides").hide()
        $(".mySlides").eq(imageIndex).attr("style", "display:block")
        console.log(imageIndex)
      }
    }, 1000)
    count += 1
  })

})
