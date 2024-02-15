$(document).ready(function() {
  var maxCharacters = (995);
  updateRemainingWords();
  $('#ad-description').on('input', updateRemainingWords);

  $('#resetbutton').click(function(){
    $('#ad-description').val('');
    limitTextareaCharacter();
  });

  $('.design-span').on('click',function(){
    var suggestiontext = $(this).text() + '.';
    var currentDescription = $('#ad-description').val();
    var newDescription =  currentDescription + ' ' + suggestiontext;
    $('#ad-description').val(newDescription);
    checkDescriptionValue();
    updateRemainingWords(); 
    limitTextareaCharacter();
  });

  $('#ad-description').on('input', function(){
    checkDescriptionValue();
    limitTextareaCharacter();
  });

  function checkDescriptionValue(){
    var descriptionValue = $('#ad-description').val().trim();
    if (descriptionValue !== ""){
      $('#ad-description').css('background-color' , ' rgb(172, 243, 172)');
      $('.description-error').hide();
      } else {
      $('#ad-description').css('background-color' , 'lightpink')
      $('.description-error').show();
        }
  }

  function updateRemainingWords() {
      var currentText = $('#ad-description').val();
    var remainingCharacters = maxCharacters -  currentText.length;

    // Display the remaining words count
    $('#remaining-words').text(remainingCharacters );
  }
  function limitTextareaCharacter(){
    var currentText = $('#ad-description').val();
    if (currentText.length >= maxCharacters){
      $('#ad-description').val(currentText.substring(0,maxCharacters));
    }
  }

  $('#toggleButton').on('click', function() {
    var suggestion = $('#suggestion');
    var buttonText = $('#toggleButton');

    if (suggestion.css('overflow') === 'hidden') {
      suggestion.css({
        'overflow': 'visible',
        'height': 'auto'
      });
      buttonText.html('Show Less Suggestions <i class="fas fa-chevron-circle-up"></i>');
    } else {
      suggestion.css({
        'overflow': 'hidden',
        'height': '88px'
      });
      buttonText.html('Show More Suggestions <i class="fas fa-chevron-circle-down"></i>');
    }
  });

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

      errorMessage.text('Enter a valid price');
      $($(".para5-text")[0]).removeClass("display-none")
    } else if(content.length > 1) {

      // Convert the input value using num2str plugin
      var result = $.fn.num2str(Number(content));

      // Display the converted result

      $('.para5-text').text( result);
    
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
  });
});

function formatResult(result) {

  if (result.text === "Popular Cities" || result.text === "Other Cities") {
    return $('<span style="font-weight:bold;">' + result.text + '</span>');
  }

  return result.text;
}


$(document).ready(function(){

  var mileageInput = $("#mileage-input");
  var errorMessage = $(".mileage-error-message"); 

  mileageInput.on('input', function() {
    var mileagevalue = $("#mileage-input").val();

    if(mileagevalue <= 0 || mileagevalue > 99999 ){
      errorMessage.text('Enter valid  mileage(1-100000)');
      mileageInput.val('');  
      mileageInput.removeClass('success').addClass('error');  
    } else {
      errorMessage.text('');
      mileageInput.removeClass('error').addClass('success');
    }
  });

  mileageInput.keypress(function (event){
    var currentmileage = mileageInput.val();
    var combineValue = currentmileage + event.key

    if (combineValue <= 0 || combineValue > 99999){
      event.preventDefault();
    }
  });
  mileageInput.keypress(function(event) {
    if (!/[0-9\.]/.test(event.key)) {
      event.preventDefault();
    }
  });
}); 


$(document).ready(function() {
  var mobileNumberInput = $('#mobile_num_field');
  var texterror = $('.number-error-message')
  mobileNumberInput.on('input', function(e) {
    debugger
    var inputValue = this.value;
    var isValidFormat = /^03\d{9}$/.test(inputValue);
    if (inputValue.length === 11 && isValidFormat) {
      mobileNumberInput.addClass('success');
      mobileNumberInput.removeClass('error');
      texterror.text('');
    } else if (inputValue.length > 11 || (inputValue.length > 0 && inputValue.length < 11)) {
      mobileNumberInput.removeClass('success');
      mobileNumberInput.addClass('error');
      texterror.text('Enter a valid mobile Number');
    } else {
      mobileNumberInput.removeClass('success', 'error');
    }

  })
});

$(document).ready(function() {
  const colorSelect = $('#car_color');
  const colorPreview = $('#color-preview');

  function updateColorPreview() {
    const selectedColor = colorSelect.find(':selected');
    const backgroundColor = selectedColor.data('color') || 'transparent';
    colorPreview.css('background-color', backgroundColor);
  }

  colorSelect.change(updateColorPreview);

  updateColorPreview();
});

$(document).ready(function() {
  var isFirstUnregistered = true;
  $('#cityDropdown').select2({
    templateResult: formatResult2
  });

  function formatResult2(result) {
    if (
      (result.text === "Un-Rigistered" && isFirstUnregistered) ||
      result.text === "Province" ||
      result.text === "Popular Cities" ||
      result.text === "Other Cities"
    ) {
      if (result.text === "Un-Rigistered") {
        isFirstUnregistered = false;
      }
      return $('<span style="font-weight:bold;">' + result.text + '</span>');
    }
    return result.text;
  }
});