if $('html').attr('role') is 'page-decks'
  decksConut = 0
  $('.float-void[role="skrollr-deck"]').each ->
    windowHeight = $(window).height()
    $(this).attr 'id', 'deck' + decksConut
    attrs =
      'data-anchor-target':    '#' + $(this).attr('id')
      'data-smooth-scrolling': 'off'
    if $(this).hasClass('free-height')
      attrs['data-bottom-top'] = 'transform: translateY(' + windowHeight + 'px);'
      bottomPos = $(this).position().top + $(this).height() - windowHeight
      bottomSkroll = -$(this).height() + windowHeight
      attrs['data-' + bottomPos] = 'transform: translateY(' + bottomSkroll + 'px);'
    else unless $(this).hasClass('fix-deck')
      attrs['data-bottom-top'] = 'transform: translateY(100%);'
      attrs['data-bottom'] = 'transform: translateY(0%);'
    $(this)
      .addClass 'skrollr-deck'
      .clone()
      .removeAttr 'role'
      .removeAttr 'id'
      .removeClass 'skrollr-deck'
      .removeClass 'float-void'
      .attr attrs
      .addClass 'float-deck'
      .appendTo 'body'
    decksConut++
    return

  elFidel.resizeDecks = ->
    console.log 'resizeDecks'
    return  if $('.free-height[role="skrollr-deck"]').length is 0
    console.log 'resizeDecks'
    windowHeight = $(window).height()
    elToUpdate = []
    $('.free-height[role="skrollr-deck"]').each ->
      $(this).height 'auto'
      el = $('[data-anchor-target="#' + $(this).attr('id') + '"]')
      keys = []
      re = new RegExp('data-[\\d]+')
      atts = el[0].attributes
      console.log atts
      for i in [0...atts.length]
        console.log atts[i]
        if atts[i].nodeName is 'data-bottom-top' or re.test(atts[i].nodeName)
          keys.push atts[i].nodeName
      console.log keys
      for i in [0...keys.length]
        el.removeAttr keys[i]
      bottomPos = $(this).position().top + $(this).height() - windowHeight
      bottomSkroll = -$(this).height() + windowHeight
      el.attr 'data-bottom-top', 'transform: translateY(' + windowHeight + 'px);'
      el.attr 'data-' + bottomPos, 'transform: translateY(' + bottomSkroll + 'px);'
      elToUpdate.push el[0]
      return
    skrollr.decks.refresh()
    skrollr.get().refresh elToUpdate
    return

  skrollr.addEvent window, 'load resize', ->
    elFidel.resizeDecks()
    return

  skrollr.decks.init
    decks: '[role="skrollr-deck"]'
    autoscroll: false
