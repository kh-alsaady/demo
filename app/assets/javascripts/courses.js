$(document).on('ready page:load', function(){
    //for display by types
    $('#display').change(function(){
        var display = $('#display').val();
        $.ajax({
            type: 'get',
            url: 'courses/',
            data: {display: display}
        });
    });
});