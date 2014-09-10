#= require "plugins/plugins.js"

#= require "google-analytics-events"

$(window).bind "load", () ->
  $body = $('body')

  setTimeout () =>
    $body.find(' > *').css('opacity', 1);
  , 250

  $gallery = $body.find('#gallery:eq(0) ul:eq(0)')

  if $gallery.length > 0

    $gallery.lightGallery
      caption: true
      desc: false