var geocoder;
var map;
var searchService;
var myLocation;
var directionsService = new google.maps.DirectionsService();
var directionsDisplay = new google.maps.DirectionsRenderer();

function fetch_data() {
     var url_path = window.location.pathname;
     $.get(url_path, function(data) {
       var addresses = data['addresses'];
       const latitude = addresses.latitude;
       const longitude = addresses.longitude;
       getLocation.draw_map(latitude, longitude);
     }, 'json');
   }


function initialize() {
    fetch_data();
  var map = new google.maps.Map(
    document.getElementById("map_canvas"), {
      center: new google.maps.LatLng(37.4419, -122.1419),
      zoom: 11,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });
  myLocation = map.getCenter();
  var marker = new google.maps.Marker({
    position: myLocation,
    map: map
  });
  searchService = new google.maps.places.PlacesService(map);
  directionsDisplay.setMap(map);
  var request = {
    location: myLocation,
    rankBy: google.maps.places.RankBy.DISTANCE,
    types: ['bar', 'cafe', 'food', 'liquor_store', 'lodging', 'meal_delivery', 'meal_takeaway', 'night_club', 'restaurant'],
    keyword: ['bar', 'pub']
  };
  searchService.nearbySearch(request, function(bars, status) {
    if (status === google.maps.places.PlacesServiceStatus.OK) {
      var barMark = new google.maps.Marker({
        position: bars[0].geometry.location,
        map: map,
        icon: {
          url: "https://maps.gstatic.com/intl/en_us/mapfiles/markers2/measle.png",
          size: new google.maps.Size(7, 7),
          anchor: new google.maps.Point(3.5, 3.5)
        }
      });
      var request = {
        origin: myLocation,
        destination: bars[0].geometry.location,
        travelMode: google.maps.TravelMode.WALKING
      };
      directionsService.route(request, function(response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
          directionsDisplay.setDirections(response);
          directionsDisplay.setOptions({
            suppressMarkers: true,
            preserveViewport: true
          });
          var polyline = getPolyline(response);
          map.setCenter(polyline.getPath().getAt(polyline.getPath().getLength() - 1));
          map.setZoom(13);

          var lineLength = google.maps.geometry.spherical.computeDistanceBetween(bars[0].geometry.location, polyline.getPath().getAt(polyline.getPath().getLength() - 1));
          var lineHeading = google.maps.geometry.spherical.computeHeading(bars[0].geometry.location, polyline.getPath().getAt(polyline.getPath().getLength() - 1));
          var markerO = new google.maps.Marker({
            position: google.maps.geometry.spherical.computeOffset(bars[0].geometry.location, lineLength * 0.1, lineHeading)
          });
          var markerD = new google.maps.Marker({
            position: google.maps.geometry.spherical.computeOffset(bars[0].geometry.location, lineLength * 0.9, lineHeading)
          });

          var markerA = new google.maps.Marker({
            position: google.maps.geometry.spherical.computeOffset(markerO.getPosition(), lineLength / 3, lineHeading - 40)
          });
          var markerB = new google.maps.Marker({
            position: google.maps.geometry.spherical.computeOffset(markerD.getPosition(), lineLength / 3, lineHeading - 140)
          });

          var curvedLine = new GmapsCubicBezier(markerO.getPosition(), markerA.getPosition(), markerB.getPosition(), markerD.getPosition(), 0.01, map);

          var line = new google.maps.Polyline({
            path: [bars[0].geometry.location, polyline.getPath().getAt(polyline.getPath().getLength() - 1)],
            strokeOpacity: 0,
            icons: [{
              icon: {
                path: 'M 0,-1 0,1',
                strokeOpacity: 1,
                scale: 4
              },
              offset: '0',
              repeat: '20px'
            }],
            // map: map
          });
        } else {
          console.log("directionsService : " + status);
        }
      });
    }
  });
}
google.maps.event.addDomListener(window, "load", initialize);

function getPolyline(result) {
  var polyline = new google.maps.Polyline({
    path: []
  });
  var path = result.routes[0].overview_path;
  var legs = result.routes[0].legs;
  for (i = 0; i < legs.length; i++) {
    var steps = legs[i].steps;
    for (j = 0; j < steps.length; j++) {
      var nextSegment = steps[j].path;
      for (k = 0; k < nextSegment.length; k++) {
        polyline.getPath().push(nextSegment[k]);
      }
    }
  }
  return polyline;
}

var GmapsCubicBezier = function(latlong1, latlong2, latlong3, latlong4, resolution, map) {
  var lat1 = latlong1.lat();
  var long1 = latlong1.lng();
  var lat2 = latlong2.lat();
  var long2 = latlong2.lng();
  var lat3 = latlong3.lat();
  var long3 = latlong3.lng();
  var lat4 = latlong4.lat();
  var long4 = latlong4.lng();

  var points = [];

  for (it = 0; it <= 1; it += resolution) {
    points.push(this.getBezier({
      x: lat1,
      y: long1
    }, {
      x: lat2,
      y: long2
    }, {
      x: lat3,
      y: long3
    }, {
      x: lat4,
      y: long4
    }, it));
  }
  var path = [];
  for (var i = 0; i < points.length - 1; i++) {
    path.push(new google.maps.LatLng(points[i].x, points[i].y));
    path.push(new google.maps.LatLng(points[i + 1].x, points[i + 1].y, false));
  }

  var Line = new google.maps.Polyline({
    path: path,
    geodesic: true,
    strokeOpacity: 0.0,
    icons: [{
      icon: {
        path: 'M 0,-1 0,1',
        strokeOpacity: 1,
        scale: 4
      },
      offset: '0',
      repeat: '20px'
    }],
    strokeColor: 'grey'
  });

  Line.setMap(map);

  return Line;
};


GmapsCubicBezier.prototype = {

  B1: function(t) {
    return t * t * t;
  },
  B2: function(t) {
    return 3 * t * t * (1 - t);
  },
  B3: function(t) {
    return 3 * t * (1 - t) * (1 - t);
  },
  B4: function(t) {
    return (1 - t) * (1 - t) * (1 - t);
  },
  getBezier: function(C1, C2, C3, C4, percent) {
    var pos = {};
    pos.x = C1.x * this.B1(percent) + C2.x * this.B2(percent) + C3.x * this.B3(percent) + C4.x * this.B4(percent);
    pos.y = C1.y * this.B1(percent) + C2.y * this.B2(percent) + C3.y * this.B3(percent) + C4.y * this.B4(percent);
    return pos;
  }
};
