blogSubscribeCont = $(role('blog-subscribe')).parent()
blogSubscribeCont.css 'top', $(window).height()/2 - blogSubscribeCont.height()/2

elFidel.leftColIsWide = true

elFidel.blogItemsSort = (blogContent,html) ->
  row = undefined
  colLeft = undefined
  colRight = undefined

  defineRow = ->
    row = $('<div class="blog-list__row" />')
    blogContent.append row
    return

  defineCols = ->
    defineRow()
    if elFidel.leftColIsWide
      colLeft = $('<div role="blog-list-col-left" class="blog-list__col_wide" />')
      colRight = $('<div role="blog-list-col-right" class="blog-list__col" />')
      row.append colLeft
      row.append colRight
      elFidel.leftColIsWide = false
    else
      colLeft = $('<div role="blog-list-col-left" class="blog-list__col" />')
      colRight = $('<div role="blog-list-col-right" class="blog-list__col_wide" />')
      row.append colLeft
      row.append colRight
      elFidel.leftColIsWide = true
    return

  appendCols = ->
    if colLeft and colRight
      row.append colLeft
      row.append colRight
    return

  html.find('[role="blog-item"],.blog-item_career').each ->
    $(this).wrapInner '<div role="blog-item-content" />'
    if $(this).hasClass 'blog-item_horizontal'
      defineRow()
      row.append $(this)
      colLeft = undefined
      colRight = undefined
    else
      defineCols() if not colLeft or not colRight
      if colLeft.height() <= colRight.height()
        colLeft.append $(this)
      else
        colRight.append $(this)

    return

  defineCols() if not colLeft or not colRight
  career = html.find(role('blog-item-career'))
  if career.length
    colRight.append career

  return

elFidel.blogPageSerialize = ->
  blogContent = $(role('blog-content'))
  html = blogContent.clone()
  blogContent.empty()
  elFidel.blogItemsSort blogContent, html
  return

elFidel.setBlogItem = (el, margin) ->
  targetSelector = '[data-counter=' + el.attr('data-counter') + ']'
  el
    .attr 'data-anchor-target', targetSelector
    .attr 'data-bottom-top', 'transform: translateY('+margin+'px);'
    .attr 'data-top-bottom', 'transform: translateY(-'+margin+'px);'
  return

elFidel.setBlogItems = (cont) ->
  marginAmount = 100
  cont.find('[role="blog-list-col-left"] [role="blog-item"][data-counter]').each ->
    elFidel.setBlogItem $(this), marginAmount*3
    return
  cont.find('[role="blog-list-col-right"] [role="blog-item"][data-counter]').each ->
    elFidel.setBlogItem $(this), marginAmount
    return
  return cont

elFidel.addBlogItems = (itemsSTR) ->

  blogContent_page = $('[role="page"] [role="blog-content"]')
  blogContent_deck = $('.float-deck [role="blog-content"]')

  html_page = $('<div />')
  html_page.append itemsSTR
  html_page.find(role('blog-item')).each ->
    $(this).attr 'data-counter', 'blogItem'+elFidel.blogItemCount
    elFidel.blogItemCount++
    return

  html_deck = html_page.clone()
  console.log html_deck.html()
  html_deck = elFidel.setBlogItems html_deck

  console.log blogContent_page
  console.log blogContent_deck

  console.log html_page.html()
  console.log html_deck.html()

  tmp = elFidel.leftColIsWide # store column sort variable
  elFidel.blogItemsSort blogContent_page, html_page
  elFidel.leftColIsWide = tmp # reset column sort variable
  elFidel.blogItemsSort blogContent_deck, html_deck

  return
