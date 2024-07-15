$(document).ready(function () {
  var $resendLink = $('#resend-link');
  var $countdownTimer = $('#countdown-timer');
  var $countdown = $('#countdown');

  function startCountdown(duration) {
    var timer = duration, seconds;
    $countdownTimer.show();
    $resendLink.hide();

    var countdownInterval = setInterval(function () {
      seconds = parseInt(timer % 60, 10);
      $countdown.text(seconds);

      if (--timer < 0) {
        clearInterval(countdownInterval);
        $countdownTimer.hide();
        $resendLink.show();
      }
    }, 1000);
  }

  // Initial countdown start on page load
  startCountdown(30);

  $resendLink.on('click', function (event) {
    event.preventDefault();

    $.ajax({
      url: '/users/resend_verification_code',
      type: 'POST',
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      },
      success: function () {
        startCountdown(30);
      },
      error: function () {
        alert('Failed to resend verification code. Please try again.');
      }
    });
  });
});
