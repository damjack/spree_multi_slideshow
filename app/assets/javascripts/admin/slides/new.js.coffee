($ '#cancel_link').click (event) ->
  event.preventDefault()

  ($ '.no-objects-found').show()

  ($ '#new_slide_link').show()
  ($ '#slides').html('')
