var popup_message = {
  init: function() {
    if($('.message-popup').length > 0){
      $('.message-popup').show();
      setTimeout(function() {
        $('.message-popup').fadeOut(2000);
      }, 4000);
    }
  }
}

$(document).on('turbolinks:load', function() {
  popup_message.init();

  $('.close').click(function(){
    $(this).parent().hide();
  });
});
