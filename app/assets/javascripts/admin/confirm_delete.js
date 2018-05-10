var confirmDelete = {
  initialize: function() {
    $('.confirm-delete-place').click(function() {
      swal({
        title: "Bạn có chắc không?",
        text: "Xóa địa điểm này?",
        icon: "warning",
        dangerMode: true,
        buttons: {
          cancel: true,
          confirm: true
        }
      })
      .then(willDelete => {
        if (willDelete) {
          var id = $(this).attr('id').split('-')[3]
          submitDeletePlace(id);
        }
        else{
          swal.close();
        }
      });
    });

    function submitDeletePlace (id) {
      $.ajax({
        url: '/admin/places/'+id,
        type: 'DELETE',
        success: function(result) {
          window.location.reload(true);
        }
      });
    }

  }
}

$(document).on("turbolinks:load", function(){
  $(function() {
    confirmDelete.initialize();
  });
})
