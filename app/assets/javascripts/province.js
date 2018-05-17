var province = {
  initialize: function() {
    $('#filter-provinces').change(function() {
      console.log("select")
      getProvinceDistricts();
    });
  }
}

function getProvinceDistricts() {
  var provinceId = $('#filter-provinces').val();
  $.ajax({
    url:  "/provinces/"+provinceId,
    dataType: "json",
    success: function(res) {
      $('#filter-districts').children().remove();
      $('#filter-districts').append('<option value="">Chọn quận huyện</option>');
      $.each(res.data.districts, function(i, item) {
        $('#filter-districts').append(`<option value="${res.data.districts[i].id}">${res.data.districts[i].name}</option>`);
        submitForm();
      });
    }
  });
}

$(document).on("turbolinks:load", function() {
  $(function() {
    getProvinceDistricts();
    province.initialize();
  });
});
