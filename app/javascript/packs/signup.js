$(document).ready(function(){
    $('#Sign-up-modal').click(function(){
        window.$('#signUpModal').modal('show')
    });

    $('.pharlo').click(function(){
        window.$('#signUpModal').modal('hide')

    });
});