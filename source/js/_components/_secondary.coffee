
$(document).ready ->

  container = document.querySelector('body > .secondary');
  msnry = new Masonry( container,
    itemSelector: 'article'
  )
