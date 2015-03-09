$(role('about-strategy-link')).click ->
  id = $(@).data().id
  $(role('about-strategy-block')).removeClass('active')
  $(role('about-strategy-block')+'[data-id="'+id+'"]').addClass('active')
  $(role('about-strategy-back')).addClass('actve')

$(role('about-strategy-back')).click ->
  $(role('about-strategy-block')).removeClass('active')
  $(role('about-strategy-back')).removeClass('actve')
