var search = {
  initialize: function(){
    $('#form-filter-place-name').change(function() {
      submitForm();
    });

    $('.filter-category-checkbox').click(function() {
      submitForm();
    });
    console.log("search");
  }
}

function submitForm() {
  console.log("submit");

  var placeName = $('#form-filter-place-name').val();
  var category_ids = [];

  $('.filter-category-place:checkbox:checked').each(function() {
    category_ids.push($(this).val());
    console.log(category_ids);
  });

  $.ajax({
    url: '/places',
    type: 'GET',
    data: {category_ids: JSON.stringify(category_ids) , "q[name_cont]": placeName},
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
