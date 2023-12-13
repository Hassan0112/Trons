$(document).ready(function() {
  var password = $('#password').val();
  var confirmPassword = $('#password_confirmation').val();
  $('.password-match-error').hide();

  $('#reset_button').click(function(e) {
    var password = $('#password').val();
    var confirmPassword = $('#password_confirmation').val();
    
    var count = 0;
    if (password !== confirmPassword) {
      count++;
      e.preventDefault();
      $('.password-match-error').show();
      localStorage.setItem('count', count);
      $('#password').removeClass('is-invalid').addClass('is-valid');
      $('#password_confirmation').removeClass('is-valid').addClass('is-invalid');
    
    }

    if (localStorage.getItem('count') > 0){
      $('#password, #password_confirmation').on('input',function(){
        var fieldPassword = $('#password').val();
        var fieldConfirmPassword = $('#password_confirmation').val();
        if (fieldPassword == '' && fieldConfirmPassword == '') {
            $('#password, #password_confirmation').css('background-image', 'none');
        } else if (fieldPassword == '') {
            $('#password').css('background-image', 'none');
        } else if (fieldConfirmPassword == '') {
            $('#password_confirmation').css('background-image', 'none');
        }
      });
    
      $('#password, #password_confirmation').on('input', function() {
        var password = $('#password').val();
        var confirmPassword = $('#password_confirmation').val();

        if (password && confirmPassword && confirmPassword.length && password !== confirmPassword) {
          $('.password-match-error').show();
          $('#password').removeClass('is-invalid').addClass('is-valid');
          $('#password_confirmation').removeClass('is-valid').addClass('is-invalid');
        } 
        else {
          $('#password_confirmation').removeClass('is-invalid').addClass('is-valid');
          $('.password-match-error').hide();
        }
      });
    }
  });
});

$(window).on('beforeunload', function() {
  localStorage.removeItem('count');
});
