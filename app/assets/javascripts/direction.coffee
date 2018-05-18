# Khởi tạo directions display và directions service
directionsDisplay = new google.maps.DirectionsRenderer
    suppressMarkers: yes # Không hiển thị đánh dấu điểm A và B
directionsSvc = new google.maps.DirectionsService()

# Gắn directions display vào map
# để nó còn biết là sẽ vẽ vào đâu ^^
directionsDisplay.setMap map

# Tạo eventListener cho đánh dấu.
# khi click vào nó, sẽ vẽ đường đi từ vị trí hiện tại trên map
# đến địa điểm được click
google.maps.event.addListener placeMarker, 'click', (e) ->
    # Tạo object chứa tùy chọn cho direction
    directionsRequest =
        origin: mapLatLng # Kinh/vĩ độ điểm A
        destination: e.latLng # Kinh/vĩ độ điểm B (vị trí hiện tại của địa điểm)
        travelMode: google.maps.DirectionsTravelMode.DRIVING # Chọn chế độ lái xe.

    # Set tuyến đường cho directions với tùy chọn ở trên
    directionsSvc.route directionsRequest, (result, status) ->
        # Kiểm tra xem có thể vẽ được đường không
        if status is google.maps.DirectionsStatus.OK
            # Vẽ lên bản đồ với kết quả nhận được
            directionsDisplay.setDirections result
        else
            alert status
