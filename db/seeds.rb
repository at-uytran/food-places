%w(db:drop db:create db:migrate).each do |task|
  Rake::Task[task].invoke
end

p "create admin"
admin = User.create! name: "admin",
  email: "admin@gmail.com",
  password: "123456",
  address: "41 Ngô Thì Nhậm, Đà Nẵng",
  descriptions: "askdjlajsdljal",
  phone: "01648447158",
  user_type: 2

# admin.create_user_location! address: "41 Ngô Thì Nhậm, Đà Nẵng",
#   district_id: @quan_lien_chieu.id,
#   coordinates: FFaker::Geolocation.lat

p "fake place categories"
@an_vat = PlaceCategory.create! name: "Ăn vặt"
@cafe = PlaceCategory.create! name: "Cà phê"
@nha_hang = PlaceCategory.create! name: "Nhà hàng"
@quan_an = PlaceCategory.create! name: "Quán ăn"
@beer = PlaceCategory.create! name: "Beer club"

p "fake food categories"
@am_thuc_mien_nam = FoodCategory.create! name: "Miền nam"
@am_thuc_mien_bac = FoodCategory.create! name: "Miền bắc"

p "Fake provinces"
@da_nang = Province.create! name: "Đà Nẵng",
  descriptions: "Thành phố du lịch với nhiều bãi biển đẹp và nhiều món ăn ngon"

@quang_nam = Province.create! name: "Quảng Nam",
  descriptions: "Quê hương xinh đẹp với nhiều địa điểm du lịch hấp dẫn và những đặc sản nổi tiếng"

p "Fake districts da nang"
@quan_hai_chau = District.create! name: "Hải Châu",
  descriptions: "Quận Hải Châu",
  province_id: @da_nang.id

@quan_ngu_hanh_son = District.create! name: "Ngũ Hành Sơn",
  descriptions: "Quân Ngũ Hành Sơn",
  province_id: @da_nang.id

@quan_cam_le = District.create! name: "Cẩm Lệ",
  descriptions: "Quận Cẩm Lệ",
  province_id: @da_nang.id

@quan_lien_chieu = District.create! name: "Liên Chiểu",
  descriptions: "Quận Liên Chiểu",
  province_id: @da_nang.id

@quan_thanh_khe = District.create! name: "Thanh Khê",
  descriptions: "Quận Thanh Khê",
  province_id: @da_nang.id

@quan_son_tra = District.create! name: "Sơn Trà",
  descriptions: "Quận Sơn Trà",
  province_id: @da_nang.id

p "fake district quang nam province"

@dai_loc = District.create! name: "Đại Lộc",
  descriptions: "Huyện Đại Lộc với nhiều thắng cảnh đẹp",
  province_id: @quang_nam.id

@hoi_an = District.create! name: "Hội An",
  descriptions: "Phố cổ Hội An say đắm lòng người",
  province_id: @quang_nam.id

# @41_ngo_thi_nham = locations.create! address: "45 Ngô Thì Nhậm", district_id: @quan_lien_chieu.id

p "create users"
10.times do |n|
  user = User.create! name: FFaker::NameVN.name,
    email: "email#{n+1}@gmail.com",
    password: "123456",
    address: "05 Ngô Văn Sở, Đà Nẵng",
    descriptions: "askdjlajsdljal",
    phone: "01648447158"

  user.create_user_location! address: "45 Ngô Thì Nhậm, Đà Nẵng",
    district_id: @quan_lien_chieu.id,
    coordinates: FFaker::Geolocation.lat
end

amthuc = FoodCategory.create!(name: "Âm thực")

# fake food categories
a_t_mien_trung = FoodCategory.create!(name: "Âm thực miền Trung",
  parent_id: amthuc.id)

a_t_mien_nam = FoodCategory.create!(name: "Âm thực miền Nam",
  parent_id: amthuc.id)

do_uong = FoodCategory.create!(name: "Thức uống")

# fake food categories
a_t_mien_trung = FoodCategory.create!(name: "Pha chế",
  parent_id: do_uong.id)

a_t_mien_nam = FoodCategory.create!(name: "Đóng chai",
  parent_id: do_uong.id)

p "fake places"
10.times do |n|
  place = Place.create! name: "Highland coffee big C #{n+1}",
    address: "255 Hùng Vương, Đà Nẵng",
    descriptions: "Một tách cà phê đậm đà của Highlands Coffee khởi nguồn
      từ những vườn cà phê trĩu hạt trên vùng cao nguyên màu mỡ của Việt Nam.
      Sau mỗi vụ thu hoạch, từng hạt cà phê được chúng tôi chọn lựa kỹ càng bằng “tay”.
      Đội ngũ công nhân của chúng tôi có trách nhiệm đảm bảo chỉ những hạt cà phê nguyên
      liệu tốt nhất được chuyển về nhà máy của Highlands Coffee. Tại đây, những thợ rang
      lành nghề với bí quyết rang độc đáo sẽ cho ra những mẻ cà phê hoàn hảo, đậm đà hương vị.",
    owner_id: User.first.id,
    open_time: Time.now.strftime("%I:%M%p"),
    close_time: 8.hours.from_now.strftime("%I:%M%p"),
    ship_price: 6,
    coordinates: FFaker::Geolocation.lat,
    place_category_id: @cafe.id,
    status: 1
  place.place_images.create! descriptions: FFaker::Lorem.paragraph[0..15]
  place.comments.create!(content: "Commented Commented Commented", user_id: 1)
  3.times do |n|
    place.user_ratings.create!(title: "Không gian tuyệt vời",
      content: "Món ăn khá ngon, không gian thoáng mát",
      user_id: 1,
      points: 8)
  end

  # place.place_setting.update_attributes allow_order: false

  puts "food for place"
  place.foods.create!(name: "Gà nướng",
    food_type: 0,
    price: 70000,
    food_category_id: a_t_mien_nam.id)
  place.foods.create!(name: "Vịt quay",
    food_type: 1,
    price: 80000,
    food_category_id: 1)
  place.foods.create!(name: "Cơm chiên",
    food_type: 1,
    price: 30000,
    food_category_id: 1)
  place.foods.create!(name: "Ba chỉ nướng",
    food_type: 1,
    price: 50000,
    food_category_id: 1)
  place.foods.create!(name: "Đậu khuôn chiên",
    food_type: 1,
    price: 50000,
    food_category_id: 1)
end

puts "create cafe gold "
cafe_gold = Place.create! name: "Gold Coffee",
  address: "48 Trần Văn Kỷ, Đà Nẵng",
  descriptions: "View quán nói chung là đẹp vì mới mở mà, mọi thứ mới sạch sẽ ,
    thức uống cũng khá ngon, chắc nằm xâu nên quán không quá đông khách khá vắng vẻ thức uống
    khởi điểm từ 15k cho các loại cà phê truyền thống, vì ở nội thành nên chắc có dịp sẽ ghé quán nữa,
    quán có một khu vực nhỏ trên tầng hai, hổm bữa mình đến trời nóng quán có máy lạnh nhưng không bật
    cũng không hiểu lý do chắc tại lúc đó xế chiều nên vắng khách thôu..
    nói chung một nơi rất đáng đến.",
  owner_id: User.first.id,
  open_time: Time.now.strftime("%I:%M%p"),
  close_time: 8.hours.from_now.strftime("%I:%M%p"),
  ship_price: 6,
  coordinates: FFaker::Geolocation.lat,
  place_category_id: @cafe.id,
  status: 1

cafe_gold.place_setting.update_attributes allow_order: true

puts "food for place"
cafe_gold.foods.create!(name: "Cà phê sữa",
  food_type: 0,
  price: 12000,
  food_category_id: do_uong.id)
cafe_gold.foods.create!(name: "Trà Gừng",
  food_type: 1,
  price: 15000,
  food_category_id: do_uong.id)
cafe_gold.foods.create!(name: "Bạc xỉu đá",
  food_type: 1,
  price: 18000,
  food_category_id: do_uong.id)
cafe_gold.foods.create!(name: "Chanh đá",
  food_type: 1,
  price: 15000,
  food_category_id: do_uong.id)

puts "end create gold coffee"

puts "create my quang bich"
myquang_bich = Place.create! name: "Mỳ quảng Bích",
  address: "05 Đặng Dung, Đà Nẵng",
  descriptions: "Mì quảng Bích nổi danh. Được cái gần nhà, nên nhà mà có khách,
    muốn thưởng thức là triển qua liền.
    Quán bán cũng tầm vài chục năm, lúc còn nhỏ mình đã từng ăn ở đây.",
  owner_id: User.first.id,
  open_time: Time.now.strftime("%I:%M%p"),
  close_time: 8.hours.from_now.strftime("%I:%M%p"),
  ship_price: 6,
  coordinates: FFaker::Geolocation.lat,
  place_category_id: @quan_an.id,
  status: 1

myquang_bich.place_setting.update_attributes allow_order: true

puts "food for myquang_bich"
myquang_bich.foods.create!(name: "Mỳ quảng bò",
  food_type: 0,
  price: 12000,
  food_category_id: amthuc.id)
myquang_bich.foods.create!(name: "Mỳ gà",
  food_type: 1,
  price: 15000,
  food_category_id: amthuc.id)
myquang_bich.foods.create!(name: "Bánh ít",
  food_type: 1,
  price: 18000,
  food_category_id: amthuc.id)
myquang_bich.foods.create!(name: "Mỳ đặc biệt",
  food_type: 1,
  price: 15000,
  food_category_id: amthuc.id)

puts "end create myquang_bich"

puts "create banh canh tuong phuong"
banh_canh_ruong = Place.create! name: "Bánh canh Ruộng Phương",
  address: "05 Hà Thị Thân, Đà Nẵng",
  descriptions: "Quán đối diện trường chuyên Lê Quý Đôn, bán cả ngày.
    Mình gọi tô chả trứng thì họ đem luôn quẩy vs ram. Nước lèo vị hơi nhạt xíu,
    tô này chắc tô nhỏ, có chả, trứng, 1 ít cá. Ăn cũng được, cũng bình thường.
    2 người ăn hết 52k, ko gọi nước uống",
  owner_id: User.first.id,
  open_time: Time.now.strftime("%I:%M%p"),
  close_time: 8.hours.from_now.strftime("%I:%M%p"),
  ship_price: 6,
  coordinates: FFaker::Geolocation.lat,
  place_category_id: @quan_an.id,
  status: 1

banh_canh_ruong.place_setting.update_attributes allow_order: true

puts "food for banh_canh_ruong"
banh_canh_ruong.foods.create!(name: "Bánh canh xương chả",
  food_type: 0,
  price: 30000,
  food_category_id: amthuc.id)
banh_canh_ruong.foods.create!(name: "bánh canh thập cẩm",
  food_type: 1,
  price: 35000,
  food_category_id: amthuc.id)
banh_canh_ruong.foods.create!(name: "Bánh canh chả",
  food_type: 1,
  price: 18000,
  food_category_id: amthuc.id)
banh_canh_ruong.foods.create!(name: "Bánh canh cá",
  food_type: 1,
  price: 25000,
  food_category_id: amthuc.id)
puts "end create banh_canh_ruong"

puts "fake orders for places"
Place.limit(3).each do |place|
  order = place.orders.create!(user_id: User.first.id)
  order.carts.create!(food_id: place.foods.first.id, quantity: 3)
  order.carts.create!(food_id: place.foods.last.id, quantity: 3)
end

order = banh_canh_ruong.orders.create!(user_id: User.last.id)
order.carts.create!(food_id: banh_canh_ruong.foods.first.id, quantity: 2)
