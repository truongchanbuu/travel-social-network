// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(name) => "Image ${name} failed to add";

  static String m1(prefix, index) => "${prefix}-img-${index}";

  static String m2(imgUrl, index) => "${imgUrl}-${index}";

  static String m3(count) =>
      "${Intl.plural(count, one: '1 day', other: '${count} days')}";

  static String m4(ticketType) => "For ${ticketType}";

  static String m5(appName) => "Hi ${appName} member";

  static String m6(name) => "Hello ${name},";

  static String m7(count) =>
      "${Intl.plural(count, one: '1 hour', other: '${count} hours')}";

  static String m8(index) => "Image at ${index}";

  static String m9(nameOfCollection) => "Illustrators${nameOfCollection}";

  static String m10(field, minLength) =>
      "Invalid ${field}! It must be at least ${minLength} characters";

  static String m11(index) => "Loading image at index ${index}";

  static String m12(count) =>
      "${Intl.plural(count, one: '1 minute', other: '${count} minutes')}";

  static String m13(count) =>
      "${Intl.plural(count, one: '1 month', other: '${count} months')}";

  static String m14(count) =>
      "${Intl.plural(count, zero: 'Review', one: 'Review', other: 'Reviews')}";

  static String m15(object) =>
      "Cannot save the ${object}! Please try again later";

  static String m16(value) => "Day ${value}";

  static String m17(name) => "Thumb for ${name}";

  static String m18(value) =>
      "${Intl.plural(value, zero: '0 review', one: '1 review', other: '${value} reviews')}";

  static String m19(start, end) =>
      "Your trip will start at: ${start} and accomplish at: ${end}";

  static String m20(count) =>
      "${Intl.plural(count, one: '1 week', other: '${count} weeks')}";

  static String m21(count) =>
      "${Intl.plural(count, one: '1 year', other: '${count} years')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutThisTicket":
            MessageLookupByLibrary.simpleMessage("About this ticket"),
        "aboutUs": MessageLookupByLibrary.simpleMessage("About us"),
        "accept": MessageLookupByLibrary.simpleMessage("Accept"),
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "addDate": MessageLookupByLibrary.simpleMessage("Add Date"),
        "addImageFailure": m0,
        "addImageLabel": MessageLookupByLibrary.simpleMessage("Add Images"),
        "addVisitorNumber":
            MessageLookupByLibrary.simpleMessage("Add Visitor Number"),
        "additionalInformation":
            MessageLookupByLibrary.simpleMessage("Additional Information"),
        "afternoonText": MessageLookupByLibrary.simpleMessage(
            "Let discover top spots and activities!!!"),
        "agreementText": MessageLookupByLibrary.simpleMessage(
            "By continuing, you agree to our "),
        "allImagesAndVideos":
            MessageLookupByLibrary.simpleMessage("All Images and Videos"),
        "allPhotos": MessageLookupByLibrary.simpleMessage("All Photos"),
        "and": MessageLookupByLibrary.simpleMessage("and"),
        "backToPreviousPage":
            MessageLookupByLibrary.simpleMessage("Back to previous page"),
        "bookingNow": MessageLookupByLibrary.simpleMessage("Booking Now"),
        "brightTheme": MessageLookupByLibrary.simpleMessage("Bright Theme"),
        "buyTicket": MessageLookupByLibrary.simpleMessage("Buy Ticket"),
        "cacheKeyWithId": m1,
        "cacheKeyWithoutId": m2,
        "canBeRescheduled":
            MessageLookupByLibrary.simpleMessage("Can be Rescheduled"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "cannotBeRescheduled":
            MessageLookupByLibrary.simpleMessage("Cannot be Rescheduled"),
        "classificationDisappointing":
            MessageLookupByLibrary.simpleMessage("Disappointing"),
        "classificationError":
            MessageLookupByLibrary.simpleMessage("Not available rating"),
        "classificationGood": MessageLookupByLibrary.simpleMessage("Good"),
        "classificationNotVeryGood":
            MessageLookupByLibrary.simpleMessage("Not Very Good"),
        "classificationOutstanding":
            MessageLookupByLibrary.simpleMessage("Outstanding"),
        "classificationPleasant":
            MessageLookupByLibrary.simpleMessage("Pleasant"),
        "classificationTerrible":
            MessageLookupByLibrary.simpleMessage("Terrible"),
        "classificationWonderful":
            MessageLookupByLibrary.simpleMessage("Wonderful"),
        "clear": MessageLookupByLibrary.simpleMessage("Clear"),
        "comment": MessageLookupByLibrary.simpleMessage("Comment"),
        "contactServiceProvider":
            MessageLookupByLibrary.simpleMessage("Contact service provider"),
        "continueLabel": MessageLookupByLibrary.simpleMessage("Continue"),
        "continueWith": MessageLookupByLibrary.simpleMessage("Continue with"),
        "countryEnglandRegionChoice":
            MessageLookupByLibrary.simpleMessage("England"),
        "countryRegion": MessageLookupByLibrary.simpleMessage("Country/Region"),
        "createTicket": MessageLookupByLibrary.simpleMessage("Create Ticket"),
        "createTicketError":
            MessageLookupByLibrary.simpleMessage("Failed to create ticket(s)"),
        "createTour":
            MessageLookupByLibrary.simpleMessage("Create your own tour"),
        "createTourPageTitle":
            MessageLookupByLibrary.simpleMessage("Create New Tour"),
        "currency": MessageLookupByLibrary.simpleMessage("Currency"),
        "currencyChoice": MessageLookupByLibrary.simpleMessage("Pound"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Dark Theme"),
        "dataStateFailure": MessageLookupByLibrary.simpleMessage(
            "Some error occurred! Please try again later!"),
        "day": MessageLookupByLibrary.simpleMessage("day"),
        "dayFormatted": m3,
        "dayUnit": MessageLookupByLibrary.simpleMessage("day|days|d"),
        "days": MessageLookupByLibrary.simpleMessage("day(s)"),
        "defaultText": MessageLookupByLibrary.simpleMessage(
            "Hope you doing well on your own journey"),
        "delete": MessageLookupByLibrary.simpleMessage("Delete"),
        "deleteConfirmText": MessageLookupByLibrary.simpleMessage(
            "Delete cannot be undone anymore"),
        "deleteConfirmTitle":
            MessageLookupByLibrary.simpleMessage("Are you sure to delete?"),
        "departure": MessageLookupByLibrary.simpleMessage("Departure"),
        "destination": MessageLookupByLibrary.simpleMessage("Destination"),
        "detail": MessageLookupByLibrary.simpleMessage("Detail"),
        "discardAlertMessage": MessageLookupByLibrary.simpleMessage(
            "Are you want to leave without saving?"),
        "discardUnsavedWork":
            MessageLookupByLibrary.simpleMessage("Discard unsaved work"),
        "duplicateLocation":
            MessageLookupByLibrary.simpleMessage("The location cannot be same"),
        "duplicateTicketAlert":
            MessageLookupByLibrary.simpleMessage("Duplicate Ticket"),
        "duplicateTicketMessage": MessageLookupByLibrary.simpleMessage(
            "There are duplicated ticket(s)! Are you want to continue creating without duplicated ticket(s)? You can modify the duplicated ticket(s) later in section My Tour"),
        "duration": MessageLookupByLibrary.simpleMessage("Duration"),
        "durationHintText": MessageLookupByLibrary.simpleMessage(
            "6 hours, 1 day, 2 weeks, 3 months, ..."),
        "easyToRefund": MessageLookupByLibrary.simpleMessage("Easy to refund"),
        "easyToReschedule":
            MessageLookupByLibrary.simpleMessage("Easy to reschedule"),
        "editPage": MessageLookupByLibrary.simpleMessage("Editor Page"),
        "editingPlaceholderText": MessageLookupByLibrary.simpleMessage(
            "Add your tour description here..."),
        "emailAnnouncement": MessageLookupByLibrary.simpleMessage(
            "We are going to sign in with your email or create a new account if you don\'t have one"),
        "englishLangChoice": MessageLookupByLibrary.simpleMessage("English"),
        "enterPasswordRequirement":
            MessageLookupByLibrary.simpleMessage("Please enter your password"),
        "enterPhoneNumberRequirement": MessageLookupByLibrary.simpleMessage(
            "Please enter your phone number"),
        "errorImage":
            MessageLookupByLibrary.simpleMessage("Failed to load image"),
        "eveningText": MessageLookupByLibrary.simpleMessage(
            "It\'s time for special dishes on elegant restaurants near you!"),
        "exclusiveOffers": MessageLookupByLibrary.simpleMessage(
            "Exclusive Offers for you - with only one simple step!"),
        "fetchDataFailure": MessageLookupByLibrary.simpleMessage(
            "Failed to fetch image from URL"),
        "forMoreInfoAboutTicket": MessageLookupByLibrary.simpleMessage(
            "For more details about this ticket"),
        "forType": m4,
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "greetingAppMember": m5,
        "guideToLocation":
            MessageLookupByLibrary.simpleMessage("Guide to location"),
        "helloUser": m6,
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "hour": MessageLookupByLibrary.simpleMessage("hour"),
        "hourFormatted": m7,
        "hourUnit": MessageLookupByLibrary.simpleMessage("hour|hours|h"),
        "howToRedeem": MessageLookupByLibrary.simpleMessage("How to redeem"),
        "image": MessageLookupByLibrary.simpleMessage("image"),
        "imageAtIndex": m8,
        "imageCollectionText": m9,
        "importantThingsYouShouldKnow": MessageLookupByLibrary.simpleMessage(
            "Important things you should know"),
        "inUseDateError":
            MessageLookupByLibrary.simpleMessage("Cannot select in use date"),
        "invalidDepartureError": MessageLookupByLibrary.simpleMessage(
            "Invalid departure location! Please choose or insert a valid location"),
        "invalidDestinationError": MessageLookupByLibrary.simpleMessage(
            "Invalid destination! Please choose or insert a valid destination"),
        "invalidDurationError":
            MessageLookupByLibrary.simpleMessage("Invalid duration"),
        "invalidForm": MessageLookupByLibrary.simpleMessage(
            "Invalid Form! Do not empty any fields or necessary information"),
        "invalidImageFileType": MessageLookupByLibrary.simpleMessage(
            "Invalid file type. Only images are allowed"),
        "invalidPhoneNumberError":
            MessageLookupByLibrary.simpleMessage("Invalid phone number"),
        "isAllow": MessageLookupByLibrary.simpleMessage("Is Allow"),
        "itinerary": MessageLookupByLibrary.simpleMessage("Itinerary"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "leave": MessageLookupByLibrary.simpleMessage("Leave"),
        "lengthLimitError": m10,
        "linkEmail": MessageLookupByLibrary.simpleMessage("Link Email"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading"),
        "loadingImageText": m11,
        "locationInfo":
            MessageLookupByLibrary.simpleMessage("Location Information"),
        "makeCallFailure": MessageLookupByLibrary.simpleMessage(
            "Could not make the phone call"),
        "manageYourAccount":
            MessageLookupByLibrary.simpleMessage("Manage your account"),
        "minute": MessageLookupByLibrary.simpleMessage("minute"),
        "minuteFormatted": m12,
        "minuteUnit":
            MessageLookupByLibrary.simpleMessage("minute|minutes|min"),
        "month": MessageLookupByLibrary.simpleMessage("month"),
        "monthFormatted": m13,
        "monthUnit": MessageLookupByLibrary.simpleMessage("month|months|mo"),
        "moreInfo": MessageLookupByLibrary.simpleMessage("More Information"),
        "morningText": MessageLookupByLibrary.simpleMessage(
            "Good morning! Ready for today\'s adventures?"),
        "myTour": MessageLookupByLibrary.simpleMessage("My Tours"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "nightText": MessageLookupByLibrary.simpleMessage(
            "Have a nice sleep! Dreams are beginning but tomorrow journey will come true"),
        "noReviews": MessageLookupByLibrary.simpleMessage(
            "There are still no reviews! Let become the first one for this tour!"),
        "noTickets":
            MessageLookupByLibrary.simpleMessage("There are no tickets!"),
        "noTours": MessageLookupByLibrary.simpleMessage(
            "There are still no tours here!"),
        "nonRefundable":
            MessageLookupByLibrary.simpleMessage("Cannot be refund"),
        "notAllowedEmpty":
            MessageLookupByLibrary.simpleMessage("Not allowed to be empty"),
        "notFound": MessageLookupByLibrary.simpleMessage("Not Found"),
        "ofWord": MessageLookupByLibrary.simpleMessage("of"),
        "outStandingFeatures":
            MessageLookupByLibrary.simpleMessage("Outstanding Features"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordRequirement": MessageLookupByLibrary.simpleMessage(
            "Password must have at least 8 characters, 1 uppercase, 1 lowercase, 1 number and 1 special character"),
        "paymentInfo":
            MessageLookupByLibrary.simpleMessage("Inclusive of taxes and fees"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
        "phoneSearchHintText": MessageLookupByLibrary.simpleMessage(
            "Enter your country name or code to search"),
        "policyDesc":
            MessageLookupByLibrary.simpleMessage("Policy Description"),
        "policyName": MessageLookupByLibrary.simpleMessage("Policy Name"),
        "popularDest":
            MessageLookupByLibrary.simpleMessage("Popular Destinations"),
        "price": MessageLookupByLibrary.simpleMessage("Price"),
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "privacyStatement":
            MessageLookupByLibrary.simpleMessage("Privacy Statement"),
        "promotionText": MessageLookupByLibrary.simpleMessage(
            "Enjoy the privilege of membership"),
        "quantity": MessageLookupByLibrary.simpleMessage("Quantity"),
        "rateForUs": MessageLookupByLibrary.simpleMessage("Rate for us"),
        "rateYourExperience":
            MessageLookupByLibrary.simpleMessage("Rate Your Experience"),
        "recentSearch": MessageLookupByLibrary.simpleMessage("Recent Search"),
        "recommendTours":
            MessageLookupByLibrary.simpleMessage("Recommend Tours"),
        "recommendation":
            MessageLookupByLibrary.simpleMessage("Recommendations"),
        "redemptionMethod":
            MessageLookupByLibrary.simpleMessage("Redemption Method"),
        "refund": MessageLookupByLibrary.simpleMessage("refund"),
        "refundAndReschedule":
            MessageLookupByLibrary.simpleMessage("Refund & Reschedule"),
        "refundPolicy": MessageLookupByLibrary.simpleMessage("Refund Policy"),
        "refundable": MessageLookupByLibrary.simpleMessage("Can be refund"),
        "reschedule": MessageLookupByLibrary.simpleMessage("reschedule"),
        "reschedulePolicy":
            MessageLookupByLibrary.simpleMessage("Reschedule Policy"),
        "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
        "reviewHint":
            MessageLookupByLibrary.simpleMessage("Write your review here..."),
        "reviewTitle": MessageLookupByLibrary.simpleMessage("Reviews & Rating"),
        "reviewed": MessageLookupByLibrary.simpleMessage("Reviewed"),
        "reviews": m14,
        "sameDateError": MessageLookupByLibrary.simpleMessage(
            "Start date and end date cannot be same"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveError": m15,
        "schedule": MessageLookupByLibrary.simpleMessage("Schedule"),
        "scheduleDay": m16,
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "searching": MessageLookupByLibrary.simpleMessage("Searching..."),
        "securityAccount":
            MessageLookupByLibrary.simpleMessage("Security Account"),
        "see": MessageLookupByLibrary.simpleMessage("See"),
        "seeHere": MessageLookupByLibrary.simpleMessage("see here"),
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "selectedDate": MessageLookupByLibrary.simpleMessage("selected date"),
        "semanticPhoneNumberCounterText": MessageLookupByLibrary.simpleMessage(
            "Maximum length of phone number"),
        "services": MessageLookupByLibrary.simpleMessage("Services"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "showMore": MessageLookupByLibrary.simpleMessage("Show More"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signUp": MessageLookupByLibrary.simpleMessage("Sign up"),
        "social": MessageLookupByLibrary.simpleMessage("Social"),
        "stay": MessageLookupByLibrary.simpleMessage("Stay"),
        "stop": MessageLookupByLibrary.simpleMessage("Stop"),
        "submit": MessageLookupByLibrary.simpleMessage("Submit"),
        "success": MessageLookupByLibrary.simpleMessage("Success"),
        "tapToRate": MessageLookupByLibrary.simpleMessage("Tap to rate"),
        "temperatureScale":
            MessageLookupByLibrary.simpleMessage("Temperature Scale"),
        "termAndCondition":
            MessageLookupByLibrary.simpleMessage("Terms and Conditions"),
        "termsOfService":
            MessageLookupByLibrary.simpleMessage("Terms of Service"),
        "thumbDesc": m17,
        "ticketCategory":
            MessageLookupByLibrary.simpleMessage("Ticket Category"),
        "ticketDesc":
            MessageLookupByLibrary.simpleMessage("Ticket Description"),
        "ticketInfo": MessageLookupByLibrary.simpleMessage("Ticket Info"),
        "ticketList": MessageLookupByLibrary.simpleMessage("Ticket List"),
        "ticketName": MessageLookupByLibrary.simpleMessage("Ticket Name"),
        "ticketRedemption":
            MessageLookupByLibrary.simpleMessage("Redemption Method"),
        "tickets": MessageLookupByLibrary.simpleMessage("Ticket(s)"),
        "totalPrice": MessageLookupByLibrary.simpleMessage("Total Price"),
        "totalReviews": m18,
        "tour": MessageLookupByLibrary.simpleMessage("Tour"),
        "tourDateAnnounce": m19,
        "tourDatesLabel": MessageLookupByLibrary.simpleMessage("Tour Dates"),
        "tourDescDetail":
            MessageLookupByLibrary.simpleMessage("Tour Description Detail"),
        "tourDescLabel":
            MessageLookupByLibrary.simpleMessage("Tour Description"),
        "tourDetails": MessageLookupByLibrary.simpleMessage("Tour Details"),
        "tourItinerary": MessageLookupByLibrary.simpleMessage("Tour Itinerary"),
        "tourNameLabel": MessageLookupByLibrary.simpleMessage("Tour Name"),
        "tourSchedule": MessageLookupByLibrary.simpleMessage("Tour Schedule"),
        "transportation":
            MessageLookupByLibrary.simpleMessage("Transportation"),
        "units": MessageLookupByLibrary.simpleMessage("Units"),
        "unitsChoice": MessageLookupByLibrary.simpleMessage("Meter Metric"),
        "unsupportedImageFormat":
            MessageLookupByLibrary.simpleMessage("Unsupported image format"),
        "unsupportedText": MessageLookupByLibrary.simpleMessage(
            "Sorry! This device is not supported"),
        "userProfile": MessageLookupByLibrary.simpleMessage("User Profile"),
        "version": MessageLookupByLibrary.simpleMessage("Version"),
        "viewAll": MessageLookupByLibrary.simpleMessage("View All"),
        "voucherCanBeUsedOn":
            MessageLookupByLibrary.simpleMessage("Voucher can be used on"),
        "voucherExp":
            MessageLookupByLibrary.simpleMessage("Voucher Expiration"),
        "week": MessageLookupByLibrary.simpleMessage("week"),
        "weekFormatted": m20,
        "weekUnit": MessageLookupByLibrary.simpleMessage("week|weeks|w"),
        "year": MessageLookupByLibrary.simpleMessage("year"),
        "yearFormatted": m21,
        "yearUnit": MessageLookupByLibrary.simpleMessage("year|years|y")
      };
}
