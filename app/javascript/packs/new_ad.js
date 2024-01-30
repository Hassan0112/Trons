$(document).ready(function() {
  var maxWords = 1000;

  // Initial update
  updateRemainingWords();

  // Update on input
  $('#ad-description').on('input', updateRemainingWords);

  function updateRemainingWords() {
    var currentWords = $('#ad-description').val().match(/\S+/g) || [];
    var remainingWords = maxWords - currentWords.length;

    // Display the remaining words count
    $('#remaining-words').text(remainingWords);
  }

  $('#toggleButton').on('click', function() {
    var suggestion = $('#suggestion');
    var buttonText = $('#toggleButton');

    if (suggestion.css('overflow') === 'hidden') {
      suggestion.css({
        'overflow': 'visible',
        'height': 'auto'
      });
      buttonText.text('Show Less');
    } else {
      suggestion.css({
        'overflow': 'hidden',
        'height': '88px'
      });
      buttonText.text('Show More');
    }
  });

// app/assets/javascripts/posts.js
  var textField = $('.validate-on-click');
  var errorMessage = $('.error-message');

  textField.on('focus', function() {
    // Reset styles on focus
    textField.css('background-color', '');
    errorMessage.text('');
  });

  textField.on('change keydown paste input', function() {
    var content = textField.val();
    if (content.length >= 0 && content.length < 2 ) {
      // Display validation error
      errorMessage.text('Enter a valid price');
      $($(".para5-text")[0]).removeClass("display-none")
    } else if(content.length > 2) {
      // Convert the input value using num2str plugin
      var result = $.fn.num2str(Number(content));

      // Display the converted result

      $('.para5-text').text(result);
    
    } 
  });
});

(function ($) {
  $.fn.num2str = function (num) {

      // Object to hold conversion functions and arrays
      var num2str = {
          ones: ['', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine'],
          tens: ['','','twenty','thirty','forty','fifty','sixty','seventy','eighty','ninety'],
          teens:['ten','eleven','twelve','thirteen','fourteen','fifteen','sixteen','seventeen','eighteen','nineteen'],

          convert_millions: function (num) {
              if (num >= 1000000) {
                  return this.convert_millions(Math.floor(num / 1000000)) + " million " + this.convert_thousands(num % 1000000);
              } else {
                  return this.convert_thousands(num);
              }
          },

          convert_thousands: function (num) {
              if (num >= 1000) {
                  return this.convert_hundreds(Math.floor(num / 1000)) + " thousand " + this.convert_hundreds(num % 1000);
              } else {
                  return this.convert_hundreds(num);
              }
          },

          convert_hundreds: function (num) {
              if (num > 99) {
                  return this.ones[Math.floor(num / 100)] + " hundred " + this.convert_tens(num % 100);
              } else {
                  return this.convert_tens(num);
              }
          },

          convert_tens: function (num) {
              if (num < 10) return this.ones[num];
              else if (num >= 10 && num < 20) return this.teens[num - 10];
              else {
                  return this.tens[Math.floor(num / 10)] + " " + this.ones[num % 10];
              }
          },

          convert: function (num) {
              if (num == 0) return "zero";
              else return this.convert_millions(num);
          }
      };

      return num2str.convert(num);
  };
})(jQuery);



$(document).ready(function() {
  $('.select2').select2({
    templateResult: formatResult
  });  // Initialize Select2 for elements with the select2 class
});

function formatResult(result) {


  // Check if the result is a group header (e.g., "Popular Cities" or "Other Cities")
  if (result.text === "Popular Cities" || result.text === "Other Cities") {
    // Apply bold styling to group headers
    return $('<span style="font-weight:bold;">' + result.text + '</span>');
  }

  return result.text; // For individual city items
}