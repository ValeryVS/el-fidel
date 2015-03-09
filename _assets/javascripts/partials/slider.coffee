sliderList = $(role('slider'))
sliderItems = $(role('slider')).find(role('slider-item'))

sliderList.append('<div role="slider-menu" class="slider-list__menu"/>')

sliderMenu = $(role('slider-menu'))

countProjects = 0
sliderItems.each ->
  ++countProjects
  $(@).attr('data-counter',countProjects)
  sliderMenu.append('<div role="slider-menu-item" class="slider-list__menu-item" data-counter="'+countProjects+'"/>')

$(role('slider-menu-item')).eq(0).addClass('active')

sliderMenuItems = $(role('slider-menu-item'))

sliderMenuItems.click ->
  return if $(@).hasClass('active')
  sliderMenuItems.removeClass('active')
  $(@).addClass('active')
  $(role('slider')).find(role('slider-item')+'.prev').removeClass('prev')
  $(role('slider')).find(role('slider-item')+'.active').removeClass('active').addClass('prev')
  $(role('slider')).find(role('slider-item')+'[data-counter="'+$(@).attr('data-counter')+'"]').addClass('active')

$(role('clients-slider')).bxSlider
  pager: false
  nextText: ''
  prevText: ''

$(role('about-us-slider')).bxSlider
  pager: false
  nextText: ''
  prevText: ''

$(role('projects-slider')).bxSlider
  pager: false
  nextSelector: '#projects-slider-next'
  prevSelector: '#projects-slider-prev'
  nextText: ''
  prevText: ''
  slideWidth: 380
  minSlides: 1
  maxSlides: 3
  slideMargin: 10
