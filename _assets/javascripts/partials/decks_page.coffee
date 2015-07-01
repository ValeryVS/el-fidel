scrollrDecksWidth = 1200

windowWidth = $(window).width()

isMobile = mobileCheck()

$(window).bind 'load', ->
  elFidel.blogPageSerialize()

  if $('html').attr('role') is 'page-decks' and windowWidth > scrollrDecksWidth and not isMobile
    windowHeight = $(window).height()

    $(role('blog-item')).each ->
      $(this).attr 'data-counter', 'blogItem'+elFidel.blogItemCount
      elFidel.blogItemCount++
      return

    decksConut = 0
    $('.float-void[role="skrollr-deck"]').each ->
      $(this).attr 'id', 'deck' + decksConut
      attrs =
        'data-anchor-target':    '#' + $(this).attr('id')
        'data-smooth-scrolling': 'off'
      if $(this).hasClass('free-height')
        attrs['data-bottom-top'] = 'transform: translateY(' + windowHeight + 'px);'
        bottomPos = $(this).offset().top + $(this).height() - windowHeight
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
      return  if $('.free-height[role="skrollr-deck"]').length is 0

      $(role('blog-item')).each ->
        if $(this).find(role('blog-item-content')).length is 0
          $(this).wrapInner '<div role="blog-item-content" />'
        return

      windowHeight = $(window).height()
      elToUpdate = []
      re = new RegExp('data-[\\d]+')

      $('.free-height[role="skrollr-deck"]').each ->
        keys = []

        $(this).height 'auto'
        el = $('[data-anchor-target="#' + $(this).attr('id') + '"]')

        atts = el[0].attributes
        for i in [0...atts.length]
          if atts[i].nodeName is 'data-bottom-top' or re.test(atts[i].nodeName)
            keys.push atts[i].nodeName
        for i in [0...keys.length]
          el.removeAttr keys[i]
        bottomPos = $(this).offset().top + $(this).height() - windowHeight
        bottomSkroll = -$(this).height() + windowHeight
        el.attr 'data-bottom-top', 'transform: translateY(' + windowHeight + 'px);'
        el.attr 'data-' + bottomPos, 'transform: translateY(' + bottomSkroll + 'px);'
        elToUpdate.push el[0]
        return

      elFidel.setBlogItems $('.float-deck')

      skrollr.decks.refresh()
      skrollr.get().refresh elToUpdate
      skrollr.get().refresh()
      return

    skrollr.addEvent window, 'load resize', ->
      elFidel.resizeDecks()
      return

    skrollr.decks.init
      decks: '[role="skrollr-deck"]'
      autoscroll: false

    elFidel.setBlogItems $('.float-deck')
    skrollr.get().refresh()
