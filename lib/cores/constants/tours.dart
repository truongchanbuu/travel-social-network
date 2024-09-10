import 'dart:math';

import 'package:travel_social_network/cores/utils/enum_utils.dart';

import '../../features/tours/data/models/tour.dart';
import '../enums/booking_status.dart';

List<Tour> generateSampleTours() {
  final random = Random();
  final locations = [
    'Hà Nội',
    'TP.HCM',
    'Đà Nẵng',
    'Hội An',
    'Huế',
    'Nha Trang',
    'Đà Lạt',
    'Phú Quốc',
    'Sapa',
    'Hạ Long'
  ];

  final descriptions = [
    'Khám phá vẻ đẹp và văn hóa độc đáo',
    'Trải nghiệm ẩm thực đặc sắc và cảnh quan tuyệt vời',
    'Tham quan di tích lịch sử và danh lam thắng cảnh',
    'Thư giãn tại bãi biển và tận hưởng không khí trong lành',
    'Khám phá hang động kỳ vĩ và thiên nhiên hoang sơ'
  ];

  return List.generate(50, (index) {
    final startDate = DateTime.now().add(Duration(days: random.nextInt(365)));
    final duration = random.nextInt(10) + 1;
    final endDate = startDate.add(Duration(days: duration));

    return Tour(
      tourId: 'TOUR${index.toString().padLeft(3, '0')}',
      tourName:
          '${locations[random.nextInt(locations.length)]} ${duration} ngày',
      tourDescription: descriptions[random.nextInt(descriptions.length)],
      tourPrice:
          (random.nextInt(9000) + 1000) * 1000.0, // 1,000,000 to 10,000,000 VND
      departure: locations[random.nextInt(locations.length)],
      destination: locations[random.nextInt(locations.length)],
      duration: duration,
      startDateTime: startDate,
      endDateTime: endDate,
      maxGroupSize: random.nextInt(20) + 5,
      currentGroupSize: random.nextInt(20),
      rating: (random.nextInt(50) + 1) / 10, // 0.1 to 5.0
      bookingStatus: stringToEnum(
          ['available', 'almost_full', 'full'][random.nextInt(3)],
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
