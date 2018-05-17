var search = {
  initialize: function(){

    $.urlParam = function(name){
      var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
      if (results==null){
        return null;
      }
      else{
        return decodeURI(results[1]) || "";
      }
    }

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

function reset() {
  $('.filter-category-place').prop('checked', false);
  $('#form-filter-place-name').val("");
}

function submitForm() {
  var placeName = $('#form-filter-place-name').val();
  var category_ids = [];
  var districtId = $('#filter-districts').val();

  $('.filter-category-place:checkbox:checked').each(function() {
    category_ids.push($(this).val());
  });

  $.ajax({
    url: '/places',
    type: 'GET',
    data: {category_ids: JSON.stringify(category_ids) , "q[name_cont]": placeName, "q[district_id_eq]": districtId},
    success: function(result) {
      $('#results').html($('#results', result).html());
      $('#pagination').html($('#pagination', result).html());
      $('.order-and-reviews').remove();
      history.pushState({}, null, this.url);
    }
  });
}

function setParams() {
  category_ids = [];
  category_ids = decodeURIComponent($.urlParam('category_ids')).replace(/'/g, '"');
  category_ids = JSON.parse(category_ids);
  if (category_ids == null || category_ids.length == 0){
    category_ids = [-1]
  }
  else {
    $(".filter-category-checkbox").find('[value=' + category_ids.join('], [name=') + ']').prop("checked", true);
  }
}

$(document).on('turbolinks:load', function() {
  $(function() {
    search.initialize();
    setParams();
  });
});
