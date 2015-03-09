$(role('projects-item')).mouseenter (e) ->
  item = $(@).find(role('projects-item-content'))
  item
    .removeClass('top')
    .removeClass('top-out')
    .removeClass('right')
    .removeClass('right-out')
    .removeClass('bottom')
    .removeClass('bottom-out')
    .removeClass('left')
    .removeClass('left-out')
  kX = e.offsetX / $(@).width()
  kY = e.offsetY / $(@).height()
  if kX < kY
    if (1 - kX) < kY
      item.addClass('bottom')
    else
      item.addClass('left')
  else
    if (1 - kX) < kY
      item.addClass('right')
    else
      item.addClass('top')

$(role('projects-item')).mouseleave (e) ->
  item = $(@).find(role('projects-item-content'))
  if item.hasClass('top')
    item
      .removeClass('top')
      .addClass('top-out')
  else if item.hasClass('right')
    item
      .removeClass('right')
      .addClass('right-out')
  else if item.hasClass('bottom')
    item
      .removeClass('bottom')
      .addClass('bottom-out')
  else if item.hasClass('left')
    item
      .removeClass('left')
      .addClass('left-out')
