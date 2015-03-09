$(role('project-about')).click ->
  x = $(window).width()*0.8
  console.log skrollrEl
  if typeof skrollrEl isnt 'undefined'
    skrollrEl.animateTo(x)
  else
    $('html,body').animate
      scrollLeft: x
    , 1000
    false
