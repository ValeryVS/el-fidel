# functions
window.elFidel = {}

# mobile check
@mobileCheck = ->
  (/Android|iPhone|iPad|iPod|BlackBerry/i).test(navigator.userAgent || navigator.vendor || window.opera)

@ieCheck = ->
  if /MSIE (\d+\.\d+);/.test(navigator.userAgent) #test for MSIE x.x
    ieversion = new Number(RegExp.$1) # capture x.x portion and store as a number
    return ieversion
  else if /Trident/.test(navigator.userAgent)
    return 10 # 10+ IE

# role selector
@role = (s) -> "[role=\"#{s}\"]"

# skrollr variable
@skrollrEl = undefined

# smooth anchor links
@smoothAnchorLinks = ->
  $("a[href*=#]:not([href=#])").click (event) ->
    if location.pathname.replace(/^\//, "") is @pathname.replace(/^\//, "") and location.hostname is @hostname
      target = $(@hash)
      target = (if target.length then target else $("[name=" + @hash.slice(1) + "]"))
      if target.length
        if typeof skrollrEl isnt 'undefined'
          top = skrollrEl.relativeToAbsolute(target[0], 'top', 'bottom')
          skrollrEl.animateTo(top)
        else
          $("html,body").animate
            scrollTop: target.offset().top
          , 1000
          false

  $("a[href=#]").click ->
    if typeof skrollrEl isnt 'undefined'
      skrollrEl.animateTo(0)
    else
      $("html,body").animate
        scrollTop: 0
      , 1000
      false
