trackOutboundLink = (url) =>
  ga 'send', 'event', 'outbound', 'click', url,
    'hitCallback': () =>
      document.location = url


$ ->

  $(document).find('a[href^="http"],a[href^="skype"]').on 'click', (e) ->
    e.preventDefault()

    $this = $(this)
    trackOutboundLink($this.attr('href'));