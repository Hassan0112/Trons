$(document).ready(function() {
  function toggleAnswer(id) {
    var answer = $('#answer' + id);
    var arrow = $('.question[data-id="' + id + '"] .arrow');

    if (answer.is(':visible')) {
      answer.hide();
      arrow.html('<i class="fa-solid fa-chevron-down"></i>');
    } else {
      answer.show();
      arrow.html('<i class="fa-solid fa-chevron-up"></i>');
    }
  }
    $('.question').click(function() {
    var id = $(this).data('id');
    toggleAnswer(id);
  });
  
});