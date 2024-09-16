import 'dart:convert';
import 'dart:math';

import 'package:travel_social_network/cores/utils/enum_utils.dart';

import '../../features/tours/data/models/tour.dart';
import '../enums/booking_status.dart';

List<Tour> generateSampleTours() {
  final random = Random();
  final locations = List.generate(
    10,
    (index) => 'Location $index',
  );

  final String description = jsonEncode([
    {
      "insert": "Khám Phá Vẻ Đẹp Đà Nẵng\n",
      "attributes": {"header": 1, "color": "blue"}
    },
    {
      "insert":
          "Hãy cùng chúng tôi trải nghiệm 5 ngày 4 đêm tuyệt vời tại thành phố biển xinh đẹp Đà Nẵng!\n\n"
    },
    {
      "insert": "Highlights của Tour:\n",
      "attributes": {"header": 2, "color": "blue"}
    },
    {
      "insert":
          "• Khám phá Bà Nà Hills và Cầu Vàng nổi tiếng\n• Thăm phố cổ Hội An đầy màu sắc\n• Tắm biển tại bãi biển Mỹ Khê tuyệt đẹp\n• Khám phá Ngũ Hành Sơn huyền bí\n• Thưởng thức ẩm thực đường phố Đà Nẵng\n\n"
    },
    {
      "insert": "Lịch Trình Chi Tiết:\n",
      "attributes": {"header": 2, "color": "blue"}
    },
    {
      "insert": "Ngày 1: Đà Nẵng - Check-in và Khám Phá\n",
      "attributes": {"header": 3, "color": "blue"}
    },
    {
      "insert":
          "• Đón tiếp tại sân bay Đà Nẵng\n• Check-in khách sạn\n• Tham quan cầu Rồng và cầu Tình Yêu\n• Ăn tối tại nhà hàng hải sản địa phương\n\n"
    },
    {
      "insert": "Ngày 2: Bà Nà Hills và Cầu Vàng\n",
      "attributes": {"header": 3, "color": "blue"}
    },
    {
      "insert":
          "• Khởi hành đi Bà Nà Hills\n• Trải nghiệm cáp treo và check-in Cầu Vàng\n• Khám phá làng Pháp và vườn hoa Le Jardin D'Amour\n• Quay về Đà Nẵng, tự do khám phá phố đêm\n\n"
    },
    {
      "insert": "Ngày 3: Hội An - Phố Cổ Đèn Lồng\n",
      "attributes": {"header": 3, "color": "blue"}
    },
    {
      "insert":
          "• Di chuyển đến Hội An\n• Tham quan phố cổ, chùa Cầu và nhà cổ\n• Workshop làm đèn lồng truyền thống\n• Đi thuyền trên sông Hoài, thả hoa đăng\n\n"
    },
    {
      "insert": "Ngày 4: Biển Mỹ Khê và Ngũ Hành Sơn\n",
      "attributes": {"header": 3, "color": "blue"}
    },
    {
      "insert":
          "• Tắm biển tại bãi biển Mỹ Khê\n• Khám phá Ngũ Hành Sơn và động Huyền Không\n• Mua sắm tại chợ Cồn\n• Ăn tối chia tay\n\n"
    },
    {
      "insert": "Ngày 5: Tạm Biệt Đà Nẵng\n",
      "attributes": {"header": 3, "color": "blue"}
    },
    {
      "insert":
          "• Ăn sáng tại khách sạn\n• Tự do mua sắm đến giờ ra sân bay\n• Kết thúc chuyến đi\n\n"
    },
    {
      "insert": "Thông Tin Bổ Sung:\n",
      "attributes": {"header": 2, "color": "blue"}
    },
    {
      "insert": "Giá tour: ",
      "attributes": {"bold": true}
    },
    {"insert": "5,000,000 VNĐ/người\n"},
    {
      "insert": "Bao gồm: ",
      "attributes": {"bold": true}
    },
    {
      "insert":
          "Khách sạn 4 sao, các bữa ăn chính, vé tham quan, hướng dẫn viên\n"
    },
    {
      "insert": "Không bao gồm: ",
      "attributes": {"bold": true}
    },
    {"insert": "Vé máy bay, chi phí cá nhân\n\n"},
    {
      "insert": "Liên hệ đặt tour: ",
      "attributes": {"bold": true}
    },
    {"insert": "0123 456 789 hoặc info@toursdanang.com\n"},
    {
      "insert":
          "\nHãy cùng chúng tôi khám phá Đà Nẵng - nơi hội tụ giữa núi, biển và văn hóa!"
    },
    {"insert": "\n"}
  ]);

  return List.generate(50, (index) {
    final startDate = DateTime.now().add(Duration(days: random.nextInt(365)));
    final duration = random.nextInt(10) + 1;
    final endDate = startDate.add(Duration(days: duration));

    return Tour(
      tourId: 'TOUR${index.toString().padLeft(3, '0')}',
      tourName: '${locations[random.nextInt(locations.length)]} $duration ngày',
      tourDescription: description,
      tourPrice:
          (random.nextInt(9000) + 1000) * 1000.0, // 1,000,000 to 10,000,000 VND
      createdBy: ['BT', 'TCB', 'ABC'][Random().nextInt(3)],
      departure: locations[random.nextInt(locations.length)],
      destination: locations[random.nextInt(locations.length)],
      duration: duration,
      startDateTime: startDate,
      endDateTime: endDate,
      maxGroupSize: random.nextInt(20) + 5,
      currentGroupSize: random.nextInt(20),
      rating: (random.nextInt(50) + 1) / 10, // 0.1 to 5.0
      bookingStatus: stringToEnum(
          ['available', 'unavailable', 'full'][random.nextInt(3)],
          BookingStatus.values),
      updatedAt: DateTime.now().subtract(Duration(days: random.nextInt(30))),
      imageUrls: const [
        'https://th.bing.com/th/id/OIP.wdbT6M2mBkQTu3dH7psDjgHaDs?rs=1&pid=ImgDetMain',
        'https://th.bing.com/th/id/R.e944c88f1d2d1edb6bc53c844c8ca19b?rik=TJCOq1cbousOeA&pid=ImgRaw&r=0',
        'https://th.bing.com/th/id/OIP.-NQNxC10BBqVrgrrEsbqEQHaE8?rs=1&pid=ImgDetMain',
        'https://th.bing.com/th/id/R.1dffa41fb03608caa46c671546c3d5ae?rik=aIiH3mllTi5YuQ&pid=ImgRaw&r=0',
      ],
    );
  });
}
