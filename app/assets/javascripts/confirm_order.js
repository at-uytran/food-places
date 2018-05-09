var confirmOrder = {
  initialize: function() {
    $('body').delegate('.show-modal-confirm', 'click', function(event) {
      updateModal();
    });
  }
}

function updateModal() {
  var currentUrl = window.location.href;
  $.ajax({
    url: currentUrl,
    type: 'GET',
    success: function(result) {
      $('#modal-confirm-order').html($('#modal-confirm-order', result).html());
    }
  });
}

$(document).on("turbolinks:load", function(){
  $(function() {
    confirmOrder.initialize();
  });
})
