
var cart = {
  initialize: function() {

    $('.btn-add-food').click(function() {
      var id = $(this).attr('id').split('-')[2]
      parentId = $(this).parents('.food').attr('id');
      foodName = $('#'+parentId+' .food-name').text();
      foodPrice = $('#'+parentId+' .food-price').text();
      addFood(id, foodName, foodPrice);
    });

    function addQuantity(id) {
      var quantity = parseInt($('.form-orders table tbody #order-food-'+id+' .quantity #user_place_order_'+id).val());
      $('.form-orders table tbody #order-food-'+id+' .quantity #user_place_order_'+id).val(quantity+1);
    }

    function addFood(id, foodName, foodPrice) {
      exist = $('.form-orders table tbody #order-food-'+id+'');
      if(exist.length > 0)
      {
        addQuantity(id)
      }else {
        $('.form-orders table tbody').
          prepend('<tr id="order-food-'+id+'"">'
                  + '<td class="food-name">'+foodName+'</td>'
                  + '<td class="width-5 quantity">'
                  + '    <input type="number" name="user_place_order['+ id +']" id="user_place_order_'+id+'" value="1" min="1">'
                  + '</td>'
                  + '<td class="food-price">'+foodPrice+'</td>'
                  + '<td><a href="javascript:void(0)" class="link icon delete-food" id="delete-food-'+id+'">'
                  + '    <i class="fa fa-trash"></i>'
                  + '    xóa</a>'
                  + '</td>'
                  + '</tr>');
      }
    }

    $('body').delegate('.delete-food', 'click', function(event) {
        $(this).parents('tr').remove();
    });
  }
}

$(document).on("turbolinks:load", function(){
  $(function() {
    cart.initialize();
  });
})
