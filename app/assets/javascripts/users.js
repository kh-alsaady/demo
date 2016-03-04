$(document).on('ready page:load', function(){
    $("input[name='display']").change(function(){
        var display = $(this).val();
        $.ajax({
            type: 'get',
            url: '/users/display',
            data: {display: display}
        })
    });
    
    // fire file_field click        
    $('#users_image').on('click', function(){
        $('#user_image').click();
        return false;
    });
});