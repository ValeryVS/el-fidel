$(role('mailfile-add')).click ->
  fileCount = $(role('mailfile-cont')+' input').length
  $(role('mailfile-cont')).append('<div role="mail-file" class="mail-file-input-block"><input class="mail-file-input" type="file" name="file_'+fileCount+'" /><div role="mail-file-delete" class="glyphicon glyphicon-remove mail-file-input-delete"></div></div>')
  lastFile = $(role('mailfile-cont')+' input').length - 1
  $(role('mailfile-cont')+' input').eq(lastFile).click()

  $(role('mail-file-delete')).click ->
    $(@).parent().remove()

hasFormValidation = ->
  typeof document.createElement("input").checkValidity is "function"

setNoValid = (input) ->
  input.parent().removeClass 'has-success'
  input.parent().addClass 'has-error'
  input.parent().addClass 'has-feedback'
  input.parent().find('.glyphicon')
    .removeClass 'glyphicon-ok'
    .addClass 'glyphicon-remove'

setValid = (input) ->
  input.parent().removeClass 'has-error'
  input.parent().addClass 'has-success'
  input.parent().addClass 'has-feedback'
  input.parent().find('.glyphicon')
    .removeClass 'glyphicon-remove'
    .addClass 'glyphicon-ok'

validateForm = ->
  emailInputJQ = $(role('mail-form')+' [name="email"]')
  emailInput = emailInputJQ[0]
  if typeof document.createElement("input").checkValidity is "function"
    if emailInput.checkValidity()
      setValid(emailInputJQ)
    else
      setNoValid(emailInputJQ)
  else
    x = emailInput.value
    atpos = x.indexOf("@")
    dotpos = x.lastIndexOf(".")
    if atpos < 1 or dotpos < atpos + 2 or dotpos + 2 >= x.length
      setNoValid(emailInputJQ)
    else
      setValid(emailInputJQ)

$(role('mail-form')).submit (e) ->
  validateForm()

  $(@).find(role('plane')).addClass('active')
  mailFormSubmit(e)

$(role('mail-form')+' [name="email"]').change (e) ->
  validateForm()
