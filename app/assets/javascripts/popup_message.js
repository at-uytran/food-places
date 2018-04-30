$(document).on('turbolinks:load', function() {
  $('.close').click(function(){
    console.log("close")
    $(this).parent().hide();
  });
});
