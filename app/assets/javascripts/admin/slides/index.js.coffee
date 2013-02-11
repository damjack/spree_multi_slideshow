$ ->
  ($ '#new_slide_link').click (event) ->
    event.preventDefault()
    ($ this).hide()
    $.ajax
      type: 'GET'
      url: @href
      data: (
        authenticity_token: AUTH_TOKEN
      )
      success: (r) ->
        ($ '#slides').html r