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

  static String m0(prefix, index) => "${prefix}-img-${index}";

  static String m1(imgUrl, index) => "${imgUrl}-${index}";

  static String m2(ticketType) => "For ${ticketType}";

  static String m3(appName) => "Hi ${appName} member";

  static String m4(name) => "Hello ${name},";

  static String m5(index) => "Image at ${index}";

  static String m6(nameOfCollection) => "Illustrators${nameOfCollection}";

  static String m7(index) => "Loading image at index ${index}";

  static String m8(count) =>
      "${Intl.plural(count, zero: 'Review', one: 'Review', other: 'Reviews')}";

  static String m9(value) => "Day ${value}";

  static String m10(name) => "Thumb for ${name}";

  static String m11(value) => "${value}";

  static String m12(start, end) =>
      "Your trip will start at: ${start} and accomplish at: ${end}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutThisTicket":
            MessageLookupByLibrary.simpleMessage("About this ticket"),
        "aboutUs": MessageLookupByLibrary.simpleMessage("About us"),
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "addDate": MessageLookupByLibrary.simpleMessage("Add Date"),
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
        "cacheKeyWithId": m0,
        "cacheKeyWithoutId": m1,
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
        "contactServiceProvider":
            MessageLookupByLibrary.simpleMessage("Contact service provider"),
        "continueWith": MessageLookupByLibrary.simpleMessage("Continue with"),
        "countryEnglandRegionChoice":
            MessageLookupByLibrary.simpleMessage("England"),
        "countryRegion": MessageLookupByLibrary.simpleMessage("Country/Region"),
        "createTicket": MessageLookupByLibrary.simpleMessage("Create Ticket"),
        "createTour":
            MessageLookupByLibrary.simpleMessage("Create your own tour"),
        "createTourPageTitle":
            MessageLookupByLibrary.simpleMessage("Create New Tour"),
        "currency": MessageLookupByLibrary.simpleMessage("Currency"),
        "currencyChoice": MessageLookupByLibrary.simpleMessage("Pound"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Dark Theme"),
        "day": MessageLookupByLibrary.simpleMessage("day"),
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
        "duration": MessageLookupByLibrary.simpleMessage("Duration"),
        "durationHintText": MessageLookupByLibrary.simpleMessage(
            "6 hours, 1 day, 2 weeks, 3 months, ..."),
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
        "forMoreInfoAboutTicket": MessageLookupByLibrary.simpleMessage(
            "For more details about this ticket"),
        "forType": m2,
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password"),
        "greetingAppMember": m3,
        "guideToLocation":
            MessageLookupByLibrary.simpleMessage("Guide to location"),
        "helloUser": m4,
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "hour": MessageLookupByLibrary.simpleMessage("hour"),
        "howToRedeem": MessageLookupByLibrary.simpleMessage("How to redeem"),
        "image": MessageLookupByLibrary.simpleMessage("image"),
        "imageAtIndex": m5,
        "imageCollectionText": m6,
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
        "invalidPhoneNumberError":
            MessageLookupByLibrary.simpleMessage("Invalid phone number"),
        "invalidTourDescError": MessageLookupByLibrary.simpleMessage(
            "Invalid tour description! It must be at least 10 characters"),
        "invalidTourNameError": MessageLookupByLibrary.simpleMessage(
            "Invalid tour name! It must be at least 10 characters"),
        "itinerary": MessageLookupByLibrary.simpleMessage("Itinerary"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "leave": MessageLookupByLibrary.simpleMessage("Leave"),
        "linkEmail": MessageLookupByLibrary.simpleMessage("Link Email"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading"),
        "loadingImageText": m7,
        "locationInfo":
            MessageLookupByLibrary.simpleMessage("Location Information"),
        "makeCallFailure": MessageLookupByLibrary.simpleMessage(
            "Could not make the phone call"),
        "manageYourAccount":
            MessageLookupByLibrary.simpleMessage("Manage your account"),
        "month": MessageLookupByLibrary.simpleMessage("month"),
        "moreInfo": MessageLookupByLibrary.simpleMessage("More Information"),
        "morningText": MessageLookupByLibrary.simpleMessage(
            "Good morning! Ready for today\'s adventures?"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "nightText": MessageLookupByLibrary.simpleMessage(
            "Have a nice sleep! Dreams are beginning but tomorrow journey will come true"),
        "nonRefundable":
            MessageLookupByLibrary.simpleMessage("Cannot be refund"),
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
        "recentSearch": MessageLookupByLibrary.simpleMessage("Recent Search"),
        "recommendTours":
            MessageLookupByLibrary.simpleMessage("Recommend Tours"),
        "recommendation":
            MessageLookupByLibrary.simpleMessage("Recommendations"),
        "redemptionMethod":
            MessageLookupByLibrary.simpleMessage("Redemption Method"),
        "refundAndReschedule":
            MessageLookupByLibrary.simpleMessage("Refund & Reschedule"),
        "refundPolicy": MessageLookupByLibrary.simpleMessage("Refund Policy"),
        "refundable": MessageLookupByLibrary.simpleMessage("Can be refund"),
        "reschedulePolicy":
            MessageLookupByLibrary.simpleMessage("Reschedule Policy"),
        "resetPassword": MessageLookupByLibrary.simpleMessage("Reset Password"),
        "reviewTitle": MessageLookupByLibrary.simpleMessage("Reviews & Rating"),
        "reviewed": MessageLookupByLibrary.simpleMessage("Reviewed"),
        "reviews": m8,
        "sameDateError": MessageLookupByLibrary.simpleMessage(
            "Start date and end date cannot be same"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "schedule": MessageLookupByLibrary.simpleMessage("Schedule"),
        "scheduleDay": m9,
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
        "temperatureScale":
            MessageLookupByLibrary.simpleMessage("Temperature Scale"),
        "termAndCondition":
            MessageLookupByLibrary.simpleMessage("Terms and Conditions"),
        "termsOfService":
            MessageLookupByLibrary.simpleMessage("Terms of Service"),
        "thumbDesc": m10,
        "ticketCategory":
            MessageLookupByLibrary.simpleMessage("Ticket Category"),
        "ticketDesc":
            MessageLookupByLibrary.simpleMessage("Ticket Description"),
        "ticketInfo": MessageLookupByLibrary.simpleMessage("Ticket Info"),
        "ticketName": MessageLookupByLibrary.simpleMessage("Ticket Name"),
        "ticketRedemption":
            MessageLookupByLibrary.simpleMessage("Redemption Method"),
        "tickets": MessageLookupByLibrary.simpleMessage("Ticket(s)"),
        "totalPrice": MessageLookupByLibrary.simpleMessage("Total Price"),
        "totalReviews": m11,
        "tour": MessageLookupByLibrary.simpleMessage("Tour"),
        "tourDateAnnounce": m12,
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
        "year": MessageLookupByLibrary.simpleMessage("year")
      };
}
