$('[data-video-click-start="true"]').bind 'click', ->
  $(@)[0].play()
  return

$('[data-video-bg="true"]').each ->
  $(this).attr 'controls', 'controls'
  return
