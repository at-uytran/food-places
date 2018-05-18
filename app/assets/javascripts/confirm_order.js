var confirmOrder = {
  initialize: function() {
    $('body').delegate('.show-modal-confirm', 'click', function(event) {
      updateModal();
    });
    $('body').delegate('#submit-confirm-order', 'click', function(event) {
      submitOrder();
    });
  }
}

function submitOrder() {
  $('#order_address').val($('#user-address').val());
  $('#order_phone').val($('#user-phone').val());
  var formOrder = $('#form-confirm-order');
  formOrder.submit();
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
