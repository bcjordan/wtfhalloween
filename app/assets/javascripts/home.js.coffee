# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(window).load(
  -> $("#option").fadeIn(2500, -> $("#choices1").fadeIn(500, -> $(".photohidden").addClass("photo"); $(".photo").removeClass("photohidden"); $("#choices2").fadeIn(500)))
)

