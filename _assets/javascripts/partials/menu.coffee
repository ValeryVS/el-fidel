$(role('menu-main-open')).click ->
  $(role('menu-main')).addClass('active')

$(role('menu-main-close')).click ->
  $(role('menu-main')).removeClass('active')
