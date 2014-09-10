#= require "plugins/plugins.js"

#= require "google-analytics-events"

$(window).bind "load", () ->
  $body = $('body')

  setTimeout () =>
    $body.find(' > *').css('opacity', 1);
  , 250



