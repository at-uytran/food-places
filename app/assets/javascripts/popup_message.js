$(document).on('turbolinks:load', function() {
  if($('.message-popup').length > 0){
    $('.message-popup').show();
    setTimeout(function() {
      $('.message-popup').fadeOut(2000);
    }, 4000);
  }

  $('.close').click(function(){
    $(this).parent().hide();
  });
});
