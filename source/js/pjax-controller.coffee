
$(document).ready ->

  if $.support.pjax

    $(document).on "click", 'a[href^="/"]:not([href^="//"])', (e) =>
        $.pjax.click(e, {container: "#main"})
