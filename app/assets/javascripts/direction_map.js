function initMap() {
  var directionsService = new google.maps.DirectionsService;
  var directionsDisplay = new google.maps.DirectionsRenderer;
  var url_path = window.location.pathname;

  $.get(url_path, function(data) {
    var addresses = data['addresses'];
    const latitude = addresses.latitude;
    const longitude = addresses.longitude;
    var map = new google.maps.Map(document.getElementById('map-item'), {
      zoom: 7,
      center: {lat: latitude, lng: longitude}
    });
    directionsDisplay.setMap(map);
  }, 'json');

  calculateAndDisplayRoute(directionsService, directionsDisplay);
}

function calculateAndDisplayRoute(directionsService, directionsDisplay) {
  var data = gon.current_location.data
  var place = gon.place_location
  var start = ''+data.geometry.location.lat+', '+data.geometry.location.lng+'';
  var end = ''+place.latitude+', '+place.longitude+'';

  directionsService.route({
    origin: start,
    destination: end,
    travelMode: 'DRIVING'
  }, function(response, status) {
    if (status === 'OK') {
      directionsDisplay.setDirections(response);
    } else {
      window.alert('Directions request failed due to ' + status);
    }
  });
}

$(document).on('turbolinks:load', function() {
  var data = gon.current_location.data
  $('#show-direction-map').click(function() {
    initMap();
  });
});
