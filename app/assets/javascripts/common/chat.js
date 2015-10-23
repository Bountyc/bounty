$( document ).ready(function() {

    $('#send_message_form').on('ajax:success',function(e, data, status, xhr){
      $("#send_message_form :input[name='message']").val('');
    }).on('ajax:error',function(e, xhr, status, error){

    });
    
});