$('#cancel_link').click(function (event) {
  event.preventDefault();
  $('#new_slide_link').show();
  $('#slides').html('');
});
