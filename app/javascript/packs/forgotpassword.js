$(document).ready(function() {
  $('#forgot-link-modal').click(function() {
    debugger
    window.$('#signInModal').modal('hide');
    window.$('#forgotModal').modal('show');
  });
});