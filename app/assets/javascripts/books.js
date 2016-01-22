$(document).ready(function(){
    //for display by type s
    $('#display').change(function(){
        var display = $('#display').val();
        $.ajax({
            type: 'get',
            url: 'books/',
            data: {display: display}
        });
    });
});