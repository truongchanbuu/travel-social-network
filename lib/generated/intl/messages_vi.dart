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

  static String m0(name) => "Không thể thêm hình ảnh ${name}";

  static String m1(prefix, index) => "${prefix}-img-${index}";

  static String m2(imgUrl, index) => "${imgUrl}-${index}";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'Bình luận', one: 'Bình luận', other: 'Bình luận')}";

  static String m4(count) => "${count} ngày";

  static String m5(ticketType) => "Dành cho ${ticketType}";

  static String m6(appName) => "Xin chào các thành viên của ${appName}";

  static String m7(name) => "Xin chào ${name},";

  static String m8(count) => "${count} giờ";

  static String m9(index) => "Hỉnh ảnh tại vị trí ${index}";

  static String m10(nameOfCollection) => "Tất cả các ảnh${nameOfCollection}";

  static String m11(field, minLength) =>
      "${field} không hợp lệ! Cần ít nhất ${minLength} ký tự";

  static String m12(index) => "Đang tải ảnh tại vị trí thứ ${index}";

  static String m13(count) => "${count} phút";

  static String m14(count) => "${count} tháng";

  static String m15(count) => "đánh giá";

  static String m16(object) => "Không thể lưu ${object}! Hãy thử lại sau";

  static String m17(value) => "Ngày thứ ${value}";

  static String m18(count) => "lượt chia sẻ";

  static String m19(name) => "Ảnh bìa của ${name}";

  static String m20(value, formattedValue) => "${value} đánh giá";

  static String m21(start, end) =>
      "Chuyến đi của bạn sẽ khởi hành vào lúc: ${start} kết thúc vào: ${end}";

  static String m22(count) => "${count} tuần";

  static String m23(count) => "${count} năm";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutThisTicket": MessageLookupByLibrary.simpleMessage("Về vé này"),
        "accept": MessageLookupByLibrary.simpleMessage("Chấp nhận"),
        "account": MessageLookupByLibrary.simpleMessage("Tài khoản"),
        "addDate": MessageLookupByLibrary.simpleMessage("Thêm thời gian"),
        "addImageFailure": m0,
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
        "authenticateFailed": MessageLookupByLibrary.simpleMessage(
            "Đăng nhập hoặc đăng ký không thành công"),
        "backToPreviousPage":
            MessageLookupByLibrary.simpleMessage("Trở về trang trước"),
        "birthDate": MessageLookupByLibrary.simpleMessage("Sinh nhật"),
        "bookingNow": MessageLookupByLibrary.simpleMessage("Đặt ngay"),
        "buyTicket": MessageLookupByLibrary.simpleMessage("Đặt vé"),
        "cacheKeyWithId": m1,
        "cacheKeyWithoutId": m2,
        "canBeRescheduled":
            MessageLookupByLibrary.simpleMessage("Có thể đổi lịch"),
        "cancel": MessageLookupByLibrary.simpleMessage("Hủy bỏ"),
        "cannotBeRescheduled":
            MessageLookupByLibrary.simpleMessage("Không thể dời lịch"),
        "chat": MessageLookupByLibrary.simpleMessage("Nhắn tin"),
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
        "comment": m3,
        "commentLabel": MessageLookupByLibrary.simpleMessage("Bình luận"),
        "confirmedPassword":
            MessageLookupByLibrary.simpleMessage("Xác nhận mật khẩu"),
        "contactServiceProvider": MessageLookupByLibrary.simpleMessage(
            "Liên hệ nhà cung cấp dịch vụ"),
        "continueLabel": MessageLookupByLibrary.simpleMessage("Tiếp tục"),
        "continueWith": MessageLookupByLibrary.simpleMessage("Tiếp tục với"),
        "countryEnglandRegionChoice":
            MessageLookupByLibrary.simpleMessage("Anh"),
        "countryRegion":
            MessageLookupByLibrary.simpleMessage("Quốc gia/Khu vực"),
        "createPost": MessageLookupByLibrary.simpleMessage("Tạo bài viết"),
        "createTicket": MessageLookupByLibrary.simpleMessage("Tạo vé"),
        "createTicketError":
            MessageLookupByLibrary.simpleMessage("Tạo vé không thành công"),
        "createTour": MessageLookupByLibrary.simpleMessage(
            "Tạo một tour du lịch cho riêng mình"),
        "createTourPageTitle":
            MessageLookupByLibrary.simpleMessage("Tạo chuyến đi mới"),
        "currency": MessageLookupByLibrary.simpleMessage("Tiền tệ"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Nền tối"),
        "dataStateFailure": MessageLookupByLibrary.simpleMessage(
            "Đã có lỗi xảy ra! Hãy thử lại sau!"),
        "day": MessageLookupByLibrary.simpleMessage("ngày"),
        "dayFormatted": m4,
        "dayUnit": MessageLookupByLibrary.simpleMessage("ngày"),
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
        "displayName": MessageLookupByLibrary.simpleMessage("Tên người dùng"),
        "duplicateLocation":
            MessageLookupByLibrary.simpleMessage("Địa điểm đã bị trùng"),
        "duplicateTicketAlert":
            MessageLookupByLibrary.simpleMessage("Vé bị trùng lặp"),
        "duplicateTicketMessage": MessageLookupByLibrary.simpleMessage(
            "Đã có vé trùng lặp trong dữ liệu của bạn! Bạn có muốn tiếp tục tạo những vé không bị trùng? Bạn có thể cập nhật những vé trùng sau trong phần Chuyến đi của tôi"),
        "duration": MessageLookupByLibrary.simpleMessage("Thời gian đi"),
        "durationHintText": MessageLookupByLibrary.simpleMessage(
            "6 giờ, 2 ngày, 3 tuần, 4 tháng, ..."),
        "easyToRefund":
            MessageLookupByLibrary.simpleMessage("Dễ dàng hoàn tiền"),
        "easyToReschedule":
            MessageLookupByLibrary.simpleMessage("Dễ dàng dời lịch"),
        "edit": MessageLookupByLibrary.simpleMessage("Chỉnh sửa"),
        "editPage": MessageLookupByLibrary.simpleMessage("Trang chỉnh sửa"),
        "editingPlaceholderText": MessageLookupByLibrary.simpleMessage(
            "Hãy viết mô tả về chuyến đi của bạn ở đây..."),
        "emailAnnouncement": MessageLookupByLibrary.simpleMessage(
            "Chúng tôi sẽ sử dụng tài khoản email của bạn để đăng nhập. Nếu chưa có tài khoản thì chúng tôi sẽ tạo mới dựa trên email đang được sử dụng"),
        "emotion": MessageLookupByLibrary.simpleMessage("Cảm xúc"),
        "englishLangChoice": MessageLookupByLibrary.simpleMessage("Tiếng Anh"),
        "enterPasswordRequirement": MessageLookupByLibrary.simpleMessage(
            "Vui lòng nhập mật khẩu của bạn"),
        "enterPhoneNumberRequirement": MessageLookupByLibrary.simpleMessage(
            "Vui lòng nhập số điện thoại của bạn"),
        "errorImage":
            MessageLookupByLibrary.simpleMessage("Failed to load image"),
        "eveningText": MessageLookupByLibrary.simpleMessage(
            "Hãy cùng thưởng thức những món ngon tại những địa điểm tuyệt vời!"),
        "exclusiveOffers": MessageLookupByLibrary.simpleMessage(
            "Ưu đãi đặc biệt dành cho bạn - chỉ với một bước đơn giản!"),
        "favorite": MessageLookupByLibrary.simpleMessage("Yêu thích"),
        "fetchDataFailure":
            MessageLookupByLibrary.simpleMessage("Lấy dữ liệu về thất bại"),
        "forMoreInfoAboutTicket": MessageLookupByLibrary.simpleMessage(
            "Để biết thông tin chi tiết về vé này"),
        "forType": m5,
        "forgotPassword": MessageLookupByLibrary.simpleMessage("Quên mật khảu"),
        "generalInfoAccount":
            MessageLookupByLibrary.simpleMessage("Thông tin tài khoản"),
        "greetingAppMember": m6,
        "guideToLocation":
            MessageLookupByLibrary.simpleMessage("Xem hướng dẫn đường đi"),
        "helloUser": m7,
        "here": MessageLookupByLibrary.simpleMessage("Ở đây"),
        "home": MessageLookupByLibrary.simpleMessage("Trang chủ"),
        "hour": MessageLookupByLibrary.simpleMessage("giờ"),
        "hourFormatted": m8,
        "hourUnit": MessageLookupByLibrary.simpleMessage("giờ|tiếng"),
        "howToRedeem": MessageLookupByLibrary.simpleMessage("Cách nhận"),
        "howYourFeeling":
            MessageLookupByLibrary.simpleMessage("Hôm nay bạn đang nghĩ gì?"),
        "image": MessageLookupByLibrary.simpleMessage("hình ảnh"),
        "imageAtIndex": m9,
        "imageCollectionText": m10,
        "imperialMetric":
            MessageLookupByLibrary.simpleMessage("Hệ đơn vị đo lường Anh"),
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
        "invalidEmail":
            MessageLookupByLibrary.simpleMessage("Email không hợp lệ"),
        "invalidForm": MessageLookupByLibrary.simpleMessage(
            "Form chưa hợp lệ! Đừng bỏ sót bất kỳ thông tin nào!"),
        "invalidImageFileType": MessageLookupByLibrary.simpleMessage(
            "File này hiện không phải là hình ảnh! Vui lòng chọn file khác"),
        "invalidInput":
            MessageLookupByLibrary.simpleMessage("Trường không hợp lệ"),
        "invalidPhoneNumberError":
            MessageLookupByLibrary.simpleMessage("Số điện thoại không hợp lệ"),
        "isAllow": MessageLookupByLibrary.simpleMessage("Cho phép"),
        "isNotSamePassword": MessageLookupByLibrary.simpleMessage(
            "Mật khẩu xác nhận không trùng khớp"),
        "itinerary": MessageLookupByLibrary.simpleMessage("lịch trình"),
        "language": MessageLookupByLibrary.simpleMessage("Ngôn ngữ"),
        "leave": MessageLookupByLibrary.simpleMessage("Rời đi"),
        "lengthLimitError": m11,
        "lightTheme": MessageLookupByLibrary.simpleMessage("Nền sáng"),
        "like": MessageLookupByLibrary.simpleMessage("Thích"),
        "linkEmail": MessageLookupByLibrary.simpleMessage("Liên kết email"),
        "loading": MessageLookupByLibrary.simpleMessage("Đang tải"),
        "loadingImageText": m12,
        "locationInfo":
            MessageLookupByLibrary.simpleMessage("Thông tin địa danh"),
        "loginAnnounce":
            MessageLookupByLibrary.simpleMessage("Vui lòng đăng nhập trước"),
        "loginToComment":
            MessageLookupByLibrary.simpleMessage("Đăng nhập để bình luận"),
        "loginToReview":
            MessageLookupByLibrary.simpleMessage("Đăng nhập để đánh giá"),
        "logout": MessageLookupByLibrary.simpleMessage("Đăng xuất"),
        "makeCallFailure": MessageLookupByLibrary.simpleMessage(
            "Không thể thực hiện cuộc gọi"),
        "manageYourAccount":
            MessageLookupByLibrary.simpleMessage("Quản lý tài khoản của bạn"),
        "meterMetric":
            MessageLookupByLibrary.simpleMessage("Hệ đơn vị đo lường mét"),
        "minute": MessageLookupByLibrary.simpleMessage("phút"),
        "minuteFormatted": m13,
        "minuteUnit": MessageLookupByLibrary.simpleMessage("phút"),
        "month": MessageLookupByLibrary.simpleMessage("tháng"),
        "monthFormatted": m14,
        "monthUnit": MessageLookupByLibrary.simpleMessage("tháng"),
        "moreAction": MessageLookupByLibrary.simpleMessage("Hành động khác"),
        "moreInfo": MessageLookupByLibrary.simpleMessage("Thêm thông tin"),
        "morningText": MessageLookupByLibrary.simpleMessage(
            "Buổi sáng tốt lành, đã sẵn sàng cho chuyến hành trình hôm nay chưa?"),
        "myTour": MessageLookupByLibrary.simpleMessage("Chuyến đi của tôi"),
        "next": MessageLookupByLibrary.simpleMessage("Kế tiếp"),
        "nightText": MessageLookupByLibrary.simpleMessage(
            "Ngủ ngon nhé! Nghỉ ngơi cho một ngày mai không ngừng khám phá!"),
        "noReviews": MessageLookupByLibrary.simpleMessage(
            "Vẫn chưa có đánh giá! Hãy trở thành người đầu tiên đánh giá chuyến đi này!"),
        "noTickets":
            MessageLookupByLibrary.simpleMessage("Không có vé để hiển thị!"),
        "noTours": MessageLookupByLibrary.simpleMessage(
            "Vẫn chưa có chuyến đi nào ở đây"),
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
        "post": MessageLookupByLibrary.simpleMessage("Đăng"),
        "postNoLoginText": MessageLookupByLibrary.simpleMessage(
            "Đăng nhập để chia sẻ những khoảnh khắc của riêng bạn"),
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
        "rateYourExperience": MessageLookupByLibrary.simpleMessage(
            "Hãy cho chúng tôi biết trải nghiệm của bạn"),
        "reAuthDialog":
            MessageLookupByLibrary.simpleMessage("Xác thực danh tính"),
        "reLogin":
            MessageLookupByLibrary.simpleMessage("Vui lòng đăng nhập lại"),
        "recentSearch":
            MessageLookupByLibrary.simpleMessage("Tìm kiếm gần đây"),
        "recommendTours": MessageLookupByLibrary.simpleMessage(
            "Những tour có thể bạn sẽ thích"),
        "recommendation": MessageLookupByLibrary.simpleMessage("Gợi ý"),
        "redemptionMethod":
            MessageLookupByLibrary.simpleMessage("Phương thức nhận vé"),
        "refund": MessageLookupByLibrary.simpleMessage("hoàn tiền"),
        "refundAndReschedule":
            MessageLookupByLibrary.simpleMessage("Hoàn tiền và Đổi lịch"),
        "refundPolicy":
            MessageLookupByLibrary.simpleMessage("Chính sách hoàn tiền"),
        "refundable": MessageLookupByLibrary.simpleMessage("Có thể hoàn tiền"),
        "reply": MessageLookupByLibrary.simpleMessage("Phản hồi"),
        "reschedule": MessageLookupByLibrary.simpleMessage("dời lịch"),
        "reschedulePolicy":
            MessageLookupByLibrary.simpleMessage("Chính sách dời vé"),
        "resetPassword":
            MessageLookupByLibrary.simpleMessage("Đặt lại mật khẩu"),
        "reviewDeleted":
            MessageLookupByLibrary.simpleMessage("Bài đánh giá đã được xóa"),
        "reviewHint": MessageLookupByLibrary.simpleMessage(
            "Viết trải nghiệm của bạn ở đây..."),
        "reviewed": MessageLookupByLibrary.simpleMessage("Đã đánh giá"),
        "reviews": m15,
        "sameDateError": MessageLookupByLibrary.simpleMessage(
            "Ngày khởi hành và ngày kết thúc không thể trùng"),
        "save": MessageLookupByLibrary.simpleMessage("Lưu"),
        "saveError": m16,
        "schedule": MessageLookupByLibrary.simpleMessage("Lịch trình"),
        "scheduleDay": m17,
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
        "share": m18,
        "shareLabel": MessageLookupByLibrary.simpleMessage("Chia sẻ"),
        "showLess": MessageLookupByLibrary.simpleMessage("Ẩn bớt"),
        "showMore": MessageLookupByLibrary.simpleMessage("Xem thêm"),
        "signIn": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "signUp": MessageLookupByLibrary.simpleMessage("Đăng ký"),
        "social": MessageLookupByLibrary.simpleMessage("Cộng đồng"),
        "stay": MessageLookupByLibrary.simpleMessage("Ở lại"),
        "stop": MessageLookupByLibrary.simpleMessage("Dừng"),
        "submit": MessageLookupByLibrary.simpleMessage("Gửi"),
        "success": MessageLookupByLibrary.simpleMessage("Thành công"),
        "tapToRate":
            MessageLookupByLibrary.simpleMessage("Nhấn vào để đánh giá"),
        "temperatureScale":
            MessageLookupByLibrary.simpleMessage("Thang đo nhiệt độ"),
        "termAndCondition":
            MessageLookupByLibrary.simpleMessage("Chính sách và Điều khoản"),
        "termsOfService":
            MessageLookupByLibrary.simpleMessage("Điều khoản dịch vụ"),
        "thumbDesc": m19,
        "ticketCategory": MessageLookupByLibrary.simpleMessage("Loại vé"),
        "ticketDesc": MessageLookupByLibrary.simpleMessage("Mô tả vé"),
        "ticketInfo":
            MessageLookupByLibrary.simpleMessage("Thông tin thêm về vé"),
        "ticketList": MessageLookupByLibrary.simpleMessage("Danh sách các vé"),
        "ticketName": MessageLookupByLibrary.simpleMessage("Tên vé"),
        "ticketRedemption":
            MessageLookupByLibrary.simpleMessage("Phương thức quy đổi"),
        "tickets": MessageLookupByLibrary.simpleMessage("Vé"),
        "totalPrice": MessageLookupByLibrary.simpleMessage("Tổng tiền"),
        "totalReviews": m20,
        "tour": MessageLookupByLibrary.simpleMessage("Chuyến đi"),
        "tourDateAnnounce": m21,
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
        "unauthenticated": MessageLookupByLibrary.simpleMessage(
            "Người dùng vẫn chưa được xác thực"),
        "units": MessageLookupByLibrary.simpleMessage("Đơn vị"),
        "unsupportedImageFormat": MessageLookupByLibrary.simpleMessage(
            "Định dạng này không được hỗ trợ"),
        "unsupportedText": MessageLookupByLibrary.simpleMessage(
            "Màn hình hiện tại không được hỗ trợ"),
        "userProfile": MessageLookupByLibrary.simpleMessage("Hồ sơ người dùng"),
        "verifyEmailAnnounce": MessageLookupByLibrary.simpleMessage(
            "Một email đã được gửi để xác thực email mới của bạn"),
        "version": MessageLookupByLibrary.simpleMessage("Phiên bản"),
        "vietnameseLangChoice":
            MessageLookupByLibrary.simpleMessage("Tiếng Việt"),
        "viewAll": MessageLookupByLibrary.simpleMessage("Xem tất cả"),
        "voucherCanBeUsedOn":
            MessageLookupByLibrary.simpleMessage("Vé có hiệu lực vào"),
        "voucherExp": MessageLookupByLibrary.simpleMessage("Thời hạn vé"),
        "week": MessageLookupByLibrary.simpleMessage("tuần"),
        "weekFormatted": m22,
        "weekUnit": MessageLookupByLibrary.simpleMessage("tuần"),
        "whatYouThinkAboutThisPost": MessageLookupByLibrary.simpleMessage(
            "Bạn nghĩ sao về bài post này?"),
        "year": MessageLookupByLibrary.simpleMessage("năm"),
        "yearFormatted": m23,
        "yearUnit": MessageLookupByLibrary.simpleMessage("năm")
      };
}
