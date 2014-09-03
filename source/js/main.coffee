#= require "plugins/plugins.js"

#= require "jquery-pjax/jquery.pjax.js"

#= require "pjax-controller"

#= require "matchHeight/jquery.matchHeight-min.js"

#= require "google-analytics-events"


$ ->

  if $('body').width() >= 650
    $('body.index .summary').matchHeight();