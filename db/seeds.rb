%w(db:drop db:create db:migrate).each do |task|
  Rake::Task[task].invoke
end

p "create admin"
User.create! name: "admin",
             email: "admin@gmail.com",
             password: "123456",
             address: "41 Ngo Thi Nham",
             descriptions: "askdjlajsdljal",
             avatar: "http://res.cloudinary.com/uytran113/image/upload/v1524024623/user-avatar-default.jpg"

p "create users"
10.times do |n|
  User.create! name: FFaker::NameVN.name,
               email: "email#{n+1}@gmail.com",
               password: "123456",
               address: "41 Ngo Thi Nham",
               descriptions: "askdjlajsdljal",
               avatar: "http://res.cloudinary.com/uytran113/image/upload/v1524024623/user-avatar-default.jpg"
end

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
@da_nang = Province.create! name: "Da Nang",
  descriptions: "Thành phố du lịch với nhiều bãi biển đẹp và nhiều món ăn ngon"

p "Fake districts"
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

# @41_ngo_thi_nham = locations.create! address: "45 Ngô Thì Nhậm", district_id: @quan_lien_chieu.id

amthuc = FoodCategory.create!(name: "Âm thực")

# fake food categories
a_t_mien_trung = FoodCategory.create!(name: "Âm thực miền Trung",
  parent_id: amthuc.id)

a_t_mien_nam = FoodCategory.create!(name: "Âm thực miền Nam",
  parent_id: amthuc.id)

p "fake places"
20.times do |n|
  place = Place.create! name: "Highland coffee Nguyễn Văn Linh #{n+1}",
    address: "45 Ngô Thì Nhậm",
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
    place_category_id: PlaceCategory.first.id
  place.place_images.create! descriptions: FFaker::Lorem.paragraph[0..15]
  place.create_location address: "45 Ngô Thì Nhậm",
    district_id: @quan_lien_chieu.id,
    coordinates: FFaker::Geolocation.lat
  place.comments.create!(content: "Commented Commented Commented", user_id: 1)
  11.times do |n|
    place.foods.create!(name: "Gà nướng",
      food_type: 0,
      price: 70000,
      food_category_id: a_t_mien_nam.id)
    place.foods.create!(name: "Bia Heineken",
      food_type: 1,
      price: 30000,
      food_category_id: 1)
  end
end
