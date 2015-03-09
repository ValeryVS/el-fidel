$(role('blog-image-cont')).each ->
  cont = $(@)
  src = $(@).find('img').attr('src')
  return  unless src.length
  image = new Image
  image.onload = ->
    width = @width
    height = @height
    if width > $(window).width()
      height = $(window).width() * height/width
      width = $(window).width()
    if height > $(window).height()
      width = $(window).height() * width/height
      height = $(window).height()
    cont.css
      backgroundImage: 'url(' + src + ')'
      width: width
      height: height
      marginLeft: width / -2
      marginTop: height / -2
    cont.show()
    return
  image.src = src
  return

Resize = ->
  $(role('blog-image-cont')).each ->
    width = $(@).width()
    height = $(@).height()
    if width > $(window).width()
      height = $(window).width() * height/width
      width = $(window).width()
    if height > $(window).height()
      width = $(window).height() * width/height
      height = $(window).height()
    $(@).css
      width: width
      height: height
  return

window.onresize = ->
  Resize()
  return

window.onorientationchange = ->
  Resize()
  return
