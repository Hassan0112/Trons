$(document).ready(function() {
  $('#forgot-link-modal').click(function() {
    $('#signInModal').modal('hide');
    $('#forgotModal').modal('show');
  });

  $('#forgotBackButton').click(function() {
    $('#forgotModal').modal('hide');
    $('#signInModal').modal('show');
  });
});