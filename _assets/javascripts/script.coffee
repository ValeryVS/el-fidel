@mailFormSubmit = (e) ->
  e.preventDefault()
  # write ajax here
  return



appendImage = (src) ->
  min = 0
  max = 280
  left = min - 0.5 + Math.random() * (max - min + 1)
  left = Math.round(left)
  min = 0
  max = 375
  top = min - 0.5 + Math.random() * (max - min + 1)
  top = Math.round(top)
  img = new Image
  img.onload = ->
    if @width > @height
      size = 'width="500"'
    else
      size = 'height="500"'
    imgEl = '<img ' + size +
            ' src="' + @src +
            '" style="left:' + left + 'px; top: ' + top + 'px;"/>'
    $(imgEl).appendTo '.blog-images'
    return
  img.src = src
  return

$(document).on 'click', '.blog-update', (event) ->
  event.preventDefault()
  $.ajax
    url: '/tumblr.php?action=get_posts'
    type: 'GET'
    dataType: 'json'
  .done (data) ->
    $('.blog-images img').remove()
    for i of data.posts
      appendImage(data.posts[i])
    console.log 'success'
    return
  .fail ->
    console.log 'error'
    return
  .always ->
    console.log 'complete'
    return
  return

$(document).on 'click', '.blog-images img', (event) ->
  event.preventDefault()
  $('.blog-images img').removeClass 'active'
  $(@).addClass 'active'
  return

###$(document).on('click','#attach_file',function(e){
  e.preventDefault();
  $('.tpl_default_custom_field_0 input').trigger('click');
})
###

$(document).on 'click', role('blog-subscribe'), (event) ->
  event.preventDefault()
  return

$(document).on 'click', role('blog-more'), (event) ->
  event.preventDefault()
  $('[role="blog-content"]').append('<div class="blog-list__row"> <div class="blog-list__col_padding"> <div class="blog-item"> <img class="blog-item__image" src="assets/content/blog/blog04.png"> <div class="blog-item__text">This add-on adds syntax highlighting and tab/code completion for Sass and SCSS files. It features Zen Coding shortcuts for many CSS properties, making you look like some kind of stylesheet wizard to everyone around you. You`ve got to like that.</div> <div class="blog-item__info"> <div class="blog-item__date">24.08</div> <div class="blog-item__author"> <img class="blog-item__avatar" src="assets/content/avatar1.png"> </div> </div> </div> <div class="blog-item"> <img class="blog-item__image" src="assets/content/blog/blog06.png"> <div class="blog-item__text">This add-on adds syntax highlighting and tab/code completion for Sass and SCSS files. It features Zen Coding shortcuts for many CSS properties, making you look like some kind of stylesheet wizard to everyone around you. You`ve got to like that.</div> <div class="blog-item__info"> <div class="blog-item__date">24.08</div> <div class="blog-item__author"> <img class="blog-item__avatar" src="assets/content/avatar1.png"> </div> </div> </div> </div> <div class="blog-list__col"> <div class="blog-item"> <img class="blog-item__image" src="assets/content/blog/blog05.png"> <div class="blog-item__text">This add-on adds syntax highlighting and tab/code completion for Sass and SCSS files. It features Zen Coding shortcuts for many CSS properties, making you look like some kind of stylesheet wizard to everyone around you. You`ve got to like that.</div> <div class="blog-item__info"> <div class="blog-item__date">24.08</div> <div class="blog-item__author"> <img class="blog-item__avatar" src="assets/content/avatar1.png"> </div> </div> </div> <div class="blog-item_career"> <div class="blog-item_career__title">Вакансия!</div> <div class="blog-item_career__text">This add-on adds syntax highlighting and tab/code completion for Sass and SCSS files.</div> <a class="blog-item_career__more" href="#">Подробнее</a> </div> </div> </div>')
  elFidel.resizeDecks();
  return
