// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a vi locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'vi';

  static String m0(prefix, index) => "${prefix}-img-${index}";

  static String m1(imgUrl, index) => "${imgUrl}-${index}";

  static String m2(name, category) =>
      "Vé ${name} - ${category} hiện đã tồn tại";

  static String m3(ticketType) => "Dành cho ${ticketType}";

  static String m4(appName) => "Xin chào các thành viên của ${appName}";

  static String m5(name) => "Xin chào ${name},";

  static String m6(index) => "Hỉnh ảnh tại vị trí ${index}";

  static String m7(nameOfCollection) => "Tất cả các ảnh${nameOfCollection}";

  static String m8(field) => "${field} không hợp lệ! Cần ít nhất 10 ký tự";

  static String m9(index) => "Đang tải ảnh tại vị trí thứ ${index}";

  static String m10(count) => "đánh giá";

  static String m11(object) => "Không thể lưu ${object}! Hãy thử lại sau";

  static String m12(value) => "Ngày thứ ${value}";

  static String m13(name) => "Ảnh bìa của ${name}";

  static String m14(value) => "${value}";

  static String m15(start, end) =>
      "Chuyến đi của bạn sẽ khởi hành vào lúc: ${start} kết thúc vào: ${end}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutThisTicket": MessageLookupByLibrary.simpleMessage("Về vé này"),
        "accept": MessageLookupByLibrary.simpleMessage("Chấp nhận"),
        "account": MessageLookupByLibrary.simpleMessage("Tài khoản"),
        "addDate": MessageLookupByLibrary.simpleMessage("Thêm thời gian"),
        "addImageLabel": MessageLookupByLibrary.simpleMessage("Thêm hình ảnh"),
        "addVisitorNumber":
            MessageLookupByLibrary.simpleMessage("Thêm số lượng người"),
        "additionalInformation":
            MessageLookupByLibrary.simpleMessage("Thông tin thêm"),
        "afternoonText": MessageLookupByLibrary.simpleMessage(
            "Hãy cùng nhau khám phá những địa điểm và những hoạt động hấp dẫn nào!"),
        "agreementText": MessageLookupByLibrary.simpleMessage(
            "Bằng cách tiếp tục, bạn đồng ý với "),
        "allImagesAndVideos":
            MessageLookupByLibrary.simpleMessage("Tất cả hình ảnh và video"),
        "allPhotos":
            MessageLookupByLibrary.simpleMessage("Tất cả các hình ảnh"),
        "and": MessageLookupByLibrary.simpleMessage("và"),
        "backToPreviousPage":
            MessageLookupByLibrary.simpleMessage("Trở về trang trước"),
        "bookingNow": MessageLookupByLibrary.simpleMessage("Đặt ngay"),
        "brightTheme": MessageLookupByLibrary.simpleMessage("Nền sáng"),
        "buyTicket": MessageLookupByLibrary.simpleMessage("Đặt vé"),
        "cacheKeyWithId": m0,
        "cacheKeyWithoutId": m1,
        "canBeRescheduled":
            MessageLookupByLibrary.simpleMessage("Có thể đổi lịch"),
        "cancel": MessageLookupByLibrary.simpleMessage("Hủy bỏ"),
        "cannotBeRescheduled":
            MessageLookupByLibrary.simpleMessage("Không thể đổi lịch"),
        "classificationDisappointing":
            MessageLookupByLibrary.simpleMessage("Thất vọng"),
        "classificationError":
            MessageLookupByLibrary.simpleMessage("Không có đánh giá"),
        "classificationGood": MessageLookupByLibrary.simpleMessage("Tốt"),
        "classificationNotVeryGood":
            MessageLookupByLibrary.simpleMessage("Không tốt lắm"),
        "classificationOutstanding":
            MessageLookupByLibrary.simpleMessage("Xuất sắc"),
        "classificationPleasant":
            MessageLookupByLibrary.simpleMessage("Dễ chịu"),
        "classificationTerrible":
            MessageLookupByLibrary.simpleMessage("Kinh khủng"),
        "classificationWonderful":
            MessageLookupByLibrary.simpleMessage("Tuyệt vời"),
        "clear": MessageLookupByLibrary.simpleMessage("Xóa"),
        "contactServiceProvider": MessageLookupByLibrary.simpleMessage(
            "Liên hệ nhà cung cấp dịch vụ"),
        "continueWith": MessageLookupByLibrary.simpleMessage("Tiếp tục với"),
        "countryEnglandRegionChoice":
            MessageLookupByLibrary.simpleMessage("Anh"),
        "countryRegion":
            MessageLookupByLibrary.simpleMessage("Quốc gia/Khu vực"),
        "createTicket": MessageLookupByLibrary.simpleMessage("Tạo vé"),
        "createTour": MessageLookupByLibrary.simpleMessage(
            "Tạo một tour du lịch cho riêng mình"),
        "createTourPageTitle":
            MessageLookupByLibrary.simpleMessage("Tạo chuyến đi mới"),
        "currency": MessageLookupByLibrary.simpleMessage("Tiền tệ"),
        "currencyChoice": MessageLookupByLibrary.simpleMessage("Bảng Anh"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Nền tối"),
        "day": MessageLookupByLibrary.simpleMessage("ngày"),
        "days": MessageLookupByLibrary.simpleMessage("ngày"),
        "defaultText": MessageLookupByLibrary.simpleMessage(
            "Hy vọng bạn vẫn đang vui vẻ trên chuyến hành trình của mình"),
        "delete": MessageLookupByLibrary.simpleMessage("Xóa"),
        "deleteConfirmText": MessageLookupByLibrary.simpleMessage(
            "Hành động xóa không thể khôi phục được"),
        "deleteConfirmTitle":
            MessageLookupByLibrary.simpleMessage("Bạn có chắc muốn xóa?"),
        "departure": MessageLookupByLibrary.simpleMessage("Điểm xuất phát"),
        "destination": MessageLookupByLibrary.simpleMessage("Điểm đến"),
        "detail": MessageLookupByLibrary.simpleMessage("chi tiết"),
        "discardAlertMessage": MessageLookupByLibrary.simpleMessage(
            "Bạn vẫn chưa lưu tiến trình chưa được lưu?"),
        "discardUnsavedWork":
            MessageLookupByLibrary.simpleMessage("Đoạn mô tả chưa được lưu"),
        "duplicateLocation":
            MessageLookupByLibrary.simpleMessage("Địa điểm đã bị trùng"),
        "duplicateTicketAlert": m2,
        "duplicateTicketMessage": MessageLookupByLibrary.simpleMessage(
            "Bạn có muốn bỏ qua vé này không? Bạn có thể cập nhật nó sau"),
        "duration": MessageLookupByLibrary.simpleMessage("Thời gian đi"),
        "durationHintText": MessageLookupByLibrary.simpleMessage(
            "6 giờ, 2 ngày, 3 tuần, 4 tháng, ..."),
        "editPage": MessageLookupByLibrary.simpleMessage("Trang chỉnh sửa"),
        "editingPlaceholderText": MessageLookupByLibrary.simpleMessage(
            "Hãy viết mô tả về chuyến đi của bạn ở đây..."),
        "emailAnnouncement": MessageLookupByLibrary.simpleMessage(
            "Chúng tôi sẽ sử dụng tài khoản email của bạn để đăng nhập. Nếu chưa có tài khoản thì chúng tôi sẽ tạo mới dựa trên email đang được sử dụng"),
        "englishLangChoice": MessageLookupByLibrary.simpleMessage("Tiếng Anh"),
        "enterPasswordRequirement": MessageLookupByLibrary.simpleMessage(
            "Vui lòng nhập mật khẩu của bạn"),
        "enterPhoneNumberRequirement": MessageLookupByLibrary.simpleMessage(
            "Vui lòng nhập số điện thoại của bạn"),
        "errorImage":
            MessageLookupByLibrary.simpleMessage("Failed to load image"),
        "eveningText": MessageLookupByLibrary.simpleMessage(
            "Chiều đến rồi! Cùng nhau thưởng thức những món ngon mới lạ cho tại một nhà hàng sang trọng nào!"),
        "exclusiveOffers": MessageLookupByLibrary.simpleMessage(
            "Ưu đãi đặc biệt dành cho bạn - chỉ với một bước đơn giản!"),
        "forMoreInfoAboutTicket": MessageLookupByLibrary.simpleMessage(
            "Để biết thông tin chi tiết về vé này"),
        "forType": m3,
        "forgotPassword": MessageLookupByLibrary.simpleMessage("Quên mật khảu"),
        "greetingAppMember": m4,
        "guideToLocation":
            MessageLookupByLibrary.simpleMessage("Xem hướng dẫn đường đi"),
        "helloUser": m5,
        "home": MessageLookupByLibrary.simpleMessage("Trang chủ"),
        "hour": MessageLookupByLibrary.simpleMessage("giờ"),
        "howToRedeem": MessageLookupByLibrary.simpleMessage("Cách nhận"),
        "image": MessageLookupByLibrary.simpleMessage("hình ảnh"),
        "imageAtIndex": m6,
        "imageCollectionText": m7,
        "importantThingsYouShouldKnow":
            MessageLookupByLibrary.simpleMessage("Một số điều cần lưu ý"),
        "inUseDateError":
            MessageLookupByLibrary.simpleMessage("Ngày này đã được chọn"),
        "invalidDepartureError": MessageLookupByLibrary.simpleMessage(
            "Điểm xuất phát không hợp lệ! Hãy chọn hoặc thêm 1 địa chỉ hợp lệ"),
        "invalidDestinationError": MessageLookupByLibrary.simpleMessage(
            "Điểm đến không hợp lệ! Hãy chọn hoặc thêm 1 địa chỉ hợp lệ"),
        "invalidDurationError": MessageLookupByLibrary.simpleMessage(
            "Khoảng thời gian không hợp lệ"),
        "invalidForm": MessageLookupByLibrary.simpleMessage("Form chưa hợp lệ"),
        "invalidPhoneNumberError":
            MessageLookupByLibrary.simpleMessage("Số điện thoại không hợp lệ"),
        "itinerary": MessageLookupByLibrary.simpleMessage("lịch trình"),
        "language": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
        "leave": MessageLookupByLibrary.simpleMessage("Rời đi"),
        "lengthLimitError": m8,
        "linkEmail": MessageLookupByLibrary.simpleMessage("Liên kết email"),
        "loading": MessageLookupByLibrary.simpleMessage("Đang tải"),
        "loadingImageText": m9,
        "locationInfo":
            MessageLookupByLibrary.simpleMessage("Thông tin địa danh"),
        "makeCallFailure": MessageLookupByLibrary.simpleMessage(
            "Không thể thực hiện cuộc gọi"),
        "manageYourAccount":
            MessageLookupByLibrary.simpleMessage("Quản lý tài khoản của bạn"),
        "month": MessageLookupByLibrary.simpleMessage("tháng"),
        "moreInfo": MessageLookupByLibrary.simpleMessage("Thêm thông tin"),
        "morningText": MessageLookupByLibrary.simpleMessage(
            "Buổi sáng tốt lành, đã sẵn sàng cho chuyến hành trình hôm nay chưa?"),
        "next": MessageLookupByLibrary.simpleMessage("Kế tiếp"),
        "nightText": MessageLookupByLibrary.simpleMessage(
            "Ngủ ngon nhé! Nghỉ ngơi cho một ngày mai không ngừng khám phá!"),
        "nonRefundable":
            MessageLookupByLibrary.simpleMessage("Không thể hoàn tiền"),
        "notFound": MessageLookupByLibrary.simpleMessage("Không tìm thấy"),
        "ofWord": MessageLookupByLibrary.simpleMessage("của"),
        "outStandingFeatures":
            MessageLookupByLibrary.simpleMessage("Những tính năng nổi bật"),
        "password": MessageLookupByLibrary.simpleMessage("Mật khẩu"),
        "passwordRequirement": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu phải có ít nhất 8 ký tự, 1 chữ hoa, 1 chữ thường, 1 số và 1 ký tự đặc biệt"),
        "paymentInfo":
            MessageLookupByLibrary.simpleMessage("Đã bao gồm các phí và thuế"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Số điện thoại"),
        "phoneSearchHintText": MessageLookupByLibrary.simpleMessage(
            "Nhập tên hoặc mã quốc gia để tìm kiếm quốc gia của bạn"),
        "policyDesc": MessageLookupByLibrary.simpleMessage("Mô tả chính sách"),
        "policyName":
            MessageLookupByLibrary.simpleMessage("Tên của chính sách"),
        "popularDest":
            MessageLookupByLibrary.simpleMessage("Những địa danh nổi tiếng"),
        "price": MessageLookupByLibrary.simpleMessage("Giá vé"),
        "privacyPolicy":
            MessageLookupByLibrary.simpleMessage("Chính sách bảo mật"),
        "privacyStatement":
            MessageLookupByLibrary.simpleMessage("Chính sách quyền riêng tư"),
        "promotionText": MessageLookupByLibrary.simpleMessage(
            "Tận hưởng những đặc quyền của thành viên"),
        "quantity": MessageLookupByLibrary.simpleMessage("Số lượng"),
        "rateForUs":
            MessageLookupByLibrary.simpleMessage("Đánh giá về chúng tôi"),
        "recentSearch":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm gần đây"),
        "recommendTours": MessageLookupByLibrary.simpleMessage(
            "Những tour có thể bạn sẽ thích"),
        "recommendation": MessageLookupByLibrary.simpleMessage("Gợi ý"),
        "redemptionMethod":
            MessageLookupByLibrary.simpleMessage("Phương thức nhận vé"),
        "refundAndReschedule":
            MessageLookupByLibrary.simpleMessage("Hoàn tiền và Đổi lịch"),
        "refundPolicy":
            MessageLookupByLibrary.simpleMessage("Chính sách hoàn tiền"),
        "refundable": MessageLookupByLibrary.simpleMessage("Có thể hoàn tiền"),
        "reschedulePolicy":
            MessageLookupByLibrary.simpleMessage("Chính sách dời vé"),
        "resetPassword":
            MessageLookupByLibrary.simpleMessage("Đặt lại mật khẩu"),
        "reviewed": MessageLookupByLibrary.simpleMessage("Đã đánh giá"),
        "reviews": m10,
        "sameDateError": MessageLookupByLibrary.simpleMessage(
            "Ngày khởi hành và ngày kết thúc không thể trùng"),
        "save": MessageLookupByLibrary.simpleMessage("Lưu"),
        "saveError": m11,
        "schedule": MessageLookupByLibrary.simpleMessage("Lịch trình"),
        "scheduleDay": m12,
        "search": MessageLookupByLibrary.simpleMessage("Tìm kiếm"),
        "searching": MessageLookupByLibrary.simpleMessage("Tìm kiếm..."),
        "securityAccount":
            MessageLookupByLibrary.simpleMessage("Bảo mật tài khoản"),
        "see": MessageLookupByLibrary.simpleMessage("Xem"),
        "seeHere": MessageLookupByLibrary.simpleMessage("Xem tại đây"),
        "select": MessageLookupByLibrary.simpleMessage("Chọn"),
        "selectedDate": MessageLookupByLibrary.simpleMessage("ngày đã chọn"),
        "semanticPhoneNumberCounterText":
            MessageLookupByLibrary.simpleMessage("Số chữ số tối đa"),
        "services": MessageLookupByLibrary.simpleMessage("Các dịch vụ"),
        "settings": MessageLookupByLibrary.simpleMessage("Cài đặt"),
        "showMore": MessageLookupByLibrary.simpleMessage("Xem thêm"),
        "signIn": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "signUp": MessageLookupByLibrary.simpleMessage("Đăng ký"),
        "social": MessageLookupByLibrary.simpleMessage("Cộng đồng"),
        "stay": MessageLookupByLibrary.simpleMessage("Ở lại"),
        "success": MessageLookupByLibrary.simpleMessage("Thành công"),
        "temperatureScale":
            MessageLookupByLibrary.simpleMessage("Thang đo nhiệt độ"),
        "termAndCondition":
            MessageLookupByLibrary.simpleMessage("Chính sách và Điều khoản"),
        "termsOfService":
            MessageLookupByLibrary.simpleMessage("Điều khoản dịch vụ"),
        "thumbDesc": m13,
        "ticketCategory": MessageLookupByLibrary.simpleMessage("Loại vé"),
        "ticketDesc": MessageLookupByLibrary.simpleMessage("Mô tả vé"),
        "ticketInfo":
            MessageLookupByLibrary.simpleMessage("Thông tin thêm về vé"),
        "ticketList": MessageLookupByLibrary.simpleMessage("Danh sách các vé"),
        "ticketName": MessageLookupByLibrary.simpleMessage("Tên vé"),
        "ticketRedemption":
            MessageLookupByLibrary.simpleMessage("Phương thức quy đổi"),
        "totalPrice": MessageLookupByLibrary.simpleMessage("Tổng tiền"),
        "totalReviews": m14,
        "tour": MessageLookupByLibrary.simpleMessage("Chuyến đi"),
        "tourDateAnnounce": m15,
        "tourDatesLabel":
            MessageLookupByLibrary.simpleMessage("Thời gian xuất phát"),
        "tourDescDetail":
            MessageLookupByLibrary.simpleMessage("Chi tiết chuyến đi"),
        "tourDescLabel":
            MessageLookupByLibrary.simpleMessage("Mô tả chuyến đi"),
        "tourDetails":
            MessageLookupByLibrary.simpleMessage("Chi tiết chuyến đi"),
        "tourItinerary":
            MessageLookupByLibrary.simpleMessage("Lịch trình chuyến đi"),
        "tourNameLabel": MessageLookupByLibrary.simpleMessage("Tên chuyến đi"),
        "tourSchedule":
            MessageLookupByLibrary.simpleMessage("Lịch trình chuyến đi"),
        "transportation":
            MessageLookupByLibrary.simpleMessage("Phương tiện di chuyển"),
        "units": MessageLookupByLibrary.simpleMessage("Đơn vị"),
        "unitsChoice": MessageLookupByLibrary.simpleMessage("Mét theo hệ mét"),
        "unsupportedText": MessageLookupByLibrary.simpleMessage(
            "Màn hình hiện tại không được hỗ trợ"),
        "userProfile": MessageLookupByLibrary.simpleMessage("Hồ sơ người dùng"),
        "version": MessageLookupByLibrary.simpleMessage("Phiên bản"),
        "viewAll": MessageLookupByLibrary.simpleMessage("Xem tất cả"),
        "voucherCanBeUsedOn":
            MessageLookupByLibrary.simpleMessage("Vé có hiệu lực vào"),
        "voucherExp": MessageLookupByLibrary.simpleMessage("Thời hạn vé"),
        "week": MessageLookupByLibrary.simpleMessage("tuần"),
        "year": MessageLookupByLibrary.simpleMessage("năm")
      };
}
