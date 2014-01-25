
$(document).ready ->

  if $.support.pjax

    $(document).on "click", 'a[href^="/"]:not([href^="//"])', (e) =>
        $.pjax.click(e, {container: "#main"})

    $(document).on  'pjax:complete', () ->
      ga('set', 'location', window.location.href)
      ga('send', 'pageview')

