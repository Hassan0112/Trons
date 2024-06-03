$(function() {
  $('#city-Dropdown').select2({
    width: "100%",
    templateResult: formatResult2
  });
  $('#year-dropdown').select2({
    minimumResultsForSearch: -1,
    width: "100%"
  });
  $('.assembly-dropdown').select2({
    minimumResultsForSearch: -1,
    width: "100%"
  });

  function formatResult2(result) {

    if (result.text === "Un-Registred" || result.text === "Province" ||result.text === "Popular Cities" || result.text === "Other Cities") {
      return $('<span style="font-weight:bold;">' + result.text + '</span>');
    }
    else if (result.text !== "Un-Registred" || result.text !== "Province" ||result.text !== "Popular Cities" || result.text !== "Other Cities") {
      return $('<span style="margin-left: 7px">' + result.text + '</span>');
    }
  
    return result.text;
  }
  // disabled and enabled continue button
  const checkbox = document.getElementById('flexCheckDefault');
  const continueButton = document.getElementById('continueButton');
  checkbox.addEventListener('change', function() {
    if (this.checked)
      continueButton.disabled = false;
    else 
      continueButton.disabled = true;
  });

  // for valid mobile number
  let phoneInput = document.getElementById('phone-input');
  let phoneError = document.getElementById('phone-error');

  phoneInput.addEventListener('input', function () {
    let phoneNumber = phoneInput.value.trim();
    let validPhone = /^\d+$/.test(phoneNumber);
    let startsWith03 = phoneNumber.startsWith('03');

    if (phoneNumber.length > 11) {
      phoneInput.value = phoneNumber.slice(0, 11);
      phoneNumber = phoneInput.value;
    }

    if (phoneNumber.length === 0) {
      phoneInput.classList.remove('is-valid');
      phoneInput.classList.add('is-invalid');
      phoneError.textContent = 'This value is required';
    } 
    else if (phoneNumber.length !== 11 || !validPhone || !startsWith03) {
      phoneInput.classList.remove('is-valid');
      phoneInput.classList.add('is-invalid');
      phoneError.textContent = 'Enter a valid 11-digit mobile number';
    } 
    else {
      phoneInput.classList.remove('is-invalid');
      phoneInput.classList.add('is-valid');
      phoneError.textContent = '';
    }
  });

  // for valid full name
  let nameInput = document.getElementById('name-input');
  let nameError = document.getElementById('name-error');

  nameInput.addEventListener('input', function() {
    let fullName = nameInput.value.trim();
    let validName = /^[a-zA-Z\s]+$/.test(fullName);

    if (fullName.length === 0){
      nameInput.classList.remove('is-valid');
      nameInput.classList.add('is-invalid');
      nameError.textContent = 'This value is required';
    }
    else if (fullName.length < 3 || !validName){
      nameInput.classList.remove('is-valid');
      nameInput.classList.add('is-invalid');
      nameError.textContent = 'Enter atleast 3 alphabets';
    } 
    else {
      nameInput.classList.remove('is-invalid');
      nameInput.classList.add('is-valid');
      nameError.textContent = '';
    }
  });

  //for valid address
  let addressInput = document.getElementById('address-input');
  let addressError = document.getElementById('address-error');

  addressInput.addEventListener('input', function(){
    let address = addressInput.value.trim();
    let validAddress = /^[a-zA-Z0-9\s]+$/.test(address);

    if(address.length === 0 || !validAddress){
      addressInput.classList.remove('is-valid');
      addressInput.classList.add('is-invalid');
      addressError.textContent = "This value is required";
    }
    else{
      addressInput.classList.remove('is-invalid');
      addressInput.classList.add('is-valid');
      addressError.textContent = "";
    }
  }); 
});

$(document).ready(function() {
  $('#resendCodeButton').click(function(event) {
    event.preventDefault();
    
    $.post('/resend_code', function(data) {
      startTimer();
    }).fail(function() {
      alert("Failed to resend verification code. Please try again.");
    });
  });

  function startTimer() {
    $('#resendCodeButton').prop('disabled', true);
    let count = 30;
    let interval = setInterval(function() {
      if (count <= 0) {
        clearInterval(interval);
        $('#resendCodeButton').prop('disabled', false);
        $('#countdownTimer').text("");
      } else {
        $('#countdownTimer').text(count + " seconds remaining");
        count--;
      }
    }, 1000);
  }
});