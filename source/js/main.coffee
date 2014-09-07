#= require "plugins/plugins.js"

#= require "jquery-pjax/jquery.pjax.js"

#= require "pjax-controller"

#= require "google-analytics-events"

$(window).bind "load", () ->
  $body = $('body')

  setTimeout () =>
    $body.find(' > *').css('opacity', 1);
  , 250



