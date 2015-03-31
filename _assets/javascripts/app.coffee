#= require jquery/dist/jquery.min.js
#= require nprogress/nprogress.js
#= require skrollr/dist/skrollr.min.js
#= require scrollr-menu/dist/skrollr.menu.min.js
#= require bxslider/dist/jquery.bxslider.min.js

#= require initiates
#= require partials/menu
#= require partials/slider
#= require partials/form
#= require partials/map
#= require partials/main_project_item
#= require partials/video
#= require partials/project_about
#= require partials/about_strategy
#= require partials/blog_image

# $('[data-parallax="true"]').attr('data-top-bottom', 'background-position: 50% 0%').attr('data-bottom-top', 'background-position: 50% 100%')

# smoothAnchorLinks()

if Modernizr.csstransforms3d
  @modernTranslateX = (x) -> 'translate3d('+x+'px,0px,0)'
  @modernTranslateY = (y) -> 'translate3d(0px,'+y+'px,0)'
else if Modernizr.csstransforms
else if Modernizr.csstransforms
  @modernTranslateX = (x) -> 'translateX('+X+'px)'
  @modernTranslateY = (y) -> 'translateY('+y+'px)'

@clearScrollrData = (el) ->
  data = el.data()
  for key of data
    el.removeAttr('data-'+key)
    delete data[key]  if /^\d+$/.test(key)
  data

@setScrollrData = (data,el) ->
  for key of data
    el.attr('data-'+key,data[key])

scrollrWidth = 1200

isMobile = mobileCheck()

Resize = ->
  skrollrEl.destroy()  if skrollrEl
  if $('body').attr('role') is 'page-vertical'
    $('body').height('auto')
  else
    $('body').height('100%')

  $('[data-size="100vh"]').height('auto')
  $('[data-size="80vw"]').width('auto')

  windowWidth = $(window).width()
  windowHeight = $(window).height()
  $('[data-size="100vh"]').each ->
    $(@).height(windowHeight)  if $(@).height() < windowHeight
  $('[data-size="80vw"]').width(windowWidth*0.8)  if windowWidth >= 1024
  $('[data-size="100vh-scrollr"]').height(windowHeight)  if windowWidth > scrollrWidth
  $(role('project-block')).css
    "padding-top": windowHeight*0.15
    "padding-bottom": windowHeight*0.05
  $(role('project-block')+' img').css
    width: 'auto'
    height: 'auto'
    maxHeight: '100%'

  $('[data-video-bg="true"]').each ->
    containerWidth = $(@).parent().width()
    containerHeight = $(@).parent().height()
    defaultAS = $(@).width() / $(@).height()
    containerAS = containerWidth/containerHeight
    console.log containerAS, defaultAS
    if containerAS >= defaultAS
      $(@).css
        width: "100%"
        height: "auto"
    else
      $(@).css
        width: "auto"
        height: "100%"

  if Math.abs(window.orientation) isnt 90 && windowWidth >= scrollrWidth && (not isMobile)
    if $('html').attr('role') is 'page-vertical'
      pageHeight = 0
      firstSection = true

      $(role('section')).each ->
        data = clearScrollrData($(@))
        $(@).data(data)

        if data.inlineScroll && data.inlineScroll is 'advantage'
          advantageList = $(@).find(role('advantage-list'))
          advantageData = clearScrollrData(advantageList)
          advantageList.data(advantageData)

          innerBegin = $(@).find(role('show-section')).height()
          innerHeight = $(@).find(role('advantage-item')).height() * ($(@).find(role('advantage-item')).length - 1)

          sectionHeight = $(@).outerHeight()
          sectionTopPosition = pageHeight + sectionHeight
          sectionBottomPosition = sectionTopPosition + innerHeight

          $(@).data(pageHeight.toString(),'transform: '+modernTranslateY(windowHeight))
          $(@).data(sectionTopPosition.toString(),'transform: '+modernTranslateY(-innerBegin))

          advantageList.data(sectionTopPosition.toString(),'transform: '+modernTranslateY(0))

          advantageList.data(sectionBottomPosition.toString(),'transform: '+modernTranslateY(-innerHeight))
          $(@).data(sectionBottomPosition.toString(),'transform: '+modernTranslateY(-innerBegin))

          setScrollrData(advantageData,advantageList)

          pageHeight = sectionBottomPosition
        else
          sectionHeight = $(@).outerHeight()
          scrollEndPosition = sectionHeight - windowHeight
          sectionBottomPosition = pageHeight + sectionHeight
          if firstSection
            firstSection = false
          else
            $(@).data(pageHeight.toString(),'transform: '+modernTranslateY(windowHeight))
            $(@).data(sectionBottomPosition.toString(),'transform:'+modernTranslateY(-scrollEndPosition))

            pageHeight = sectionBottomPosition

        setScrollrData(data,$(@))

    else if $('html').attr('role') is 'page-horizontal'
      $(role('page')).width('100%')

      sectionVideoWidth = $(role('section-video')).width()
      sectionContentWidth = $(role('section-content')).width()
      sectionInfoWidth = $(role('section-info')).width()
      pageEnd = sectionContentWidth + sectionInfoWidth

      # section-content
      section = $(role('section-content'))

      data = clearScrollrData(section)
      section.data(data)

      endPos = -(sectionContentWidth-windowWidth)

      section.data("0",'transform: '+modernTranslateX(sectionVideoWidth))
      section.data(sectionContentWidth.toString(),'transform: '+modernTranslateX(endPos))

      setScrollrData(data,section)

      # section-info
      section = $(role('section-info'))

      data = clearScrollrData(section)
      section.data(data)

      endPos = -(sectionInfoWidth-windowWidth)

      section.data(sectionContentWidth.toString(),'transform: '+modernTranslateX(windowWidth))
      section.data(pageEnd.toString(),'transform: '+modernTranslateX(endPos))

      setScrollrData(data,section)

      $(role('parallax-style-item')).each ->
        data = clearScrollrData($(@))
        $(@).data(data)

        if data.parallaxType is "back"
          posBegin = 300
          posEnd = -300
        else
          posBegin = -300
          posEnd = 300

        $(@).data("0",'transform: '+modernTranslateX(posBegin))
        $(@).data(sectionContentWidth.toString(),'transform: '+modernTranslateX(posEnd))

        setScrollrData(data,$(@))

    @skrollrEl = skrollr.init()
    skrollr.menu.init(@skrollrEl, {
      animate: true
    })

  else
    if $('html').attr('role') is 'page-horizontal'
      sectionVideoWidth = $(role('section-video')).width()
      sectionContentWidth = $(role('section-content')).width()
      sectionInfoWidth = $(role('section-info')).width()

      $(role('page')).css
        width: sectionVideoWidth + sectionContentWidth + sectionInfoWidth
      $(role('section-content')).css
        left: sectionVideoWidth
      $(role('section-info')).css
        # left: sectionVideoWidth + sectionContentWidth # ????
        left: sectionContentWidth

  return

NProgress.start()

window.onload = ->
  Resize()
  NProgress.done()
  $('html').addClass('loaded')

window.onresize = ->
  Resize()

window.onorientationchange = ->
  Resize()
