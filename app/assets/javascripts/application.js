// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery_ujs
//= require jquery-1.11.3.min
//= require jquery-ui.min
//= require turbolinks
//= require bootstrap.min
//= require_tree .
//= require toastr
//= require_self


$(document).on('ready page:load', function(){
    
    function showPassword(passwordField){
        //id name type size class
        var prevFieldToPasswordField = passwordField.prev();
        
        var id = passwordField.attr('id');
        var name = passwordField.attr('name');
        var fieldType = passwordField.attr('type');
        var fieldClass = passwordField.attr('class');        
        var value = passwordField.val();    
        var newType = (fieldType == 'password') ? 'text' : 'password';        
        passwordField.remove();
        prevFieldToPasswordField.before("<input type="+newType+" id="+id+" name="+name+" class=" + fieldClass + " value='"+value+"' >");
    }
    
    $("#accor-container").accordion({
        collapsible: true,
        cookie: {expires: 2},
        icons: {
            header: 'ui-icon-plus',
            activeHeader: 'ui-icon-minus'
        }
    });
   
    
    
});



