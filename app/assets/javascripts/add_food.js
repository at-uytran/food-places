
var cart = {
  initialize: function() {

    $('.btn-add-food').click(function() {
      console.log("click")
    });
  }
}

$(document).on("turbolinks:load", function(){
  $(function() {
    cart.initialize();
  });
})
