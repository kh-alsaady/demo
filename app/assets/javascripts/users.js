$(document).ready(function(){
    $("input[name='display']").change(function(){
        var display = $(this).val();
        $.ajax({
            type: 'get',
            url: '/users/display',
            data: {display: display}
        })
    });
    
});