  var getLocation = {
   initialize: function() {
     getLocation.fetch_data();
   },

   fetch_data: function() {
     var url_path = window.location.pathname;
     $.get(url_path, function(data) {
      console.log(data)
       var addresses = data['addresses'];
       const latitude = addresses.latitude;
       const longitude = addresses.longitude;
       getLocation.draw_map(latitude, longitude);
     }, 'json');
   },

   draw_map: function(lat, lng) {
     var companyLatlng = new google.maps.LatLng(lat, lng);
     var mapOptions = {
       zoom: 15,
       center: companyLatlng,
       mapTypeId: google.maps.MapTypeId.ROADMAP
     }
     var map = new google.maps.Map(document.getElementById('map-item'), mapOptions);
     var marker = new google.maps.Marker({
       position: companyLatlng,
       map: map
     });
   }
}
$(document).on('turbolinks:load', function(){
  $(function() {
     getLocation.initialize();
   });
});

