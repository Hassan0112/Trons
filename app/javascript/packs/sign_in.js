
$(document).ready(function() {
  $('#signIn-link').click(function() {
    $('#signUpModal').modal('hide');
    $('#signInModal').modal('show');
  });

  $('#signInBackButton').click(function() {
    $('#signInModal').modal('hide');
    $('#signUpModal').modal('show');
  });
});