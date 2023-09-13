$(document).ready(function(){
    $('#mainmodalbutton').click(function(){
        window.$('#exampleModal').modal('show')
    });

    $('.pharlo').click(function(){
        window.$('#exampleModal').modal('hide')

    });
});