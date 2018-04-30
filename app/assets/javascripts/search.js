var search = {
  initialize: function(){
    $('#form-filter-place-name').change(function() {
      submitForm();
    });

    $('.filter-category-place').click(function() {
      submitForm();
    });

    $('#filter-districts').change(function() {
      submitForm();
    });
  }
}

function submitForm() {
  console.log("submit");

  var placeName = $('#form-filter-place-name').val();
  var category_ids = [];
  var districtId = $('#filter-districts').val();


  $('.filter-category-place:checkbox:checked').each(function() {
    category_ids.push($(this).val());
    console.log(category_ids);
  });

  $.ajax({
    url: '/places',
    type: 'GET',
    data: {category_ids: JSON.stringify(category_ids) , "q[name_cont]": placeName, "q[location_district_id_eq]": districtId},
    success: function(result) {
      $('#results').html($('#results', result).html());
    }
  });
}

$(document).on('turbolinks:load', function() {
  $(function() {
    search.initialize();
  });
});
