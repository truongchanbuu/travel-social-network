// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `of`
  String get ofWord {
    return Intl.message(
      'of',
      name: 'ofWord',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Hi {appName} member`
  String greetingAppMember(String appName) {
    return Intl.message(
      'Hi $appName member',
      name: 'greetingAppMember',
      desc: '',
      args: [appName],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Social`
  String get social {
    return Intl.message(
      'Social',
      name: 'social',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Dark Theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Bright Theme`
  String get brightTheme {
    return Intl.message(
      'Bright Theme',
      name: 'brightTheme',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get aboutUs {
    return Intl.message(
      'About us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Rate for us`
  String get rateForUs {
    return Intl.message(
      'Rate for us',
      name: 'rateForUs',
      desc: '',
      args: [],
    );
  }

  /// `Manage your account`
  String get manageYourAccount {
    return Intl.message(
      'Manage your account',
      name: 'manageYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get termAndCondition {
    return Intl.message(
      'Terms and Conditions',
      name: 'termAndCondition',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Statement`
  String get privacyStatement {
    return Intl.message(
      'Privacy Statement',
      name: 'privacyStatement',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `By continuing, you agree to our `
  String get agreementText {
    return Intl.message(
      'By continuing, you agree to our ',
      name: 'agreementText',
      desc: '',
      args: [],
    );
  }

  /// `Security Account`
  String get securityAccount {
    return Intl.message(
      'Security Account',
      name: 'securityAccount',
      desc: '',
      args: [],
    );
  }

  /// `Link Email`
  String get linkEmail {
    return Intl.message(
      'Link Email',
      name: 'linkEmail',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `User Profile`
  String get userProfile {
    return Intl.message(
      'User Profile',
      name: 'userProfile',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy the privilege of membership`
  String get promotionText {
    return Intl.message(
      'Enjoy the privilege of membership',
      name: 'promotionText',
      desc: '',
      args: [],
    );
  }

  /// `Exclusive Offers for you - with only one simple step!`
  String get exclusiveOffers {
    return Intl.message(
      'Exclusive Offers for you - with only one simple step!',
      name: 'exclusiveOffers',
      desc: '',
      args: [],
    );
  }

  /// `Sorry! This device is not supported`
  String get unsupportedText {
    return Intl.message(
      'Sorry! This device is not supported',
      name: 'unsupportedText',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get englishLangChoice {
    return Intl.message(
      'English',
      name: 'englishLangChoice',
      desc: '',
      args: [],
    );
  }

  /// `Country/Region`
  String get countryRegion {
    return Intl.message(
      'Country/Region',
      name: 'countryRegion',
      desc: '',
      args: [],
    );
  }

  /// `England`
  String get countryEnglandRegionChoice {
    return Intl.message(
      'England',
      name: 'countryEnglandRegionChoice',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Pound`
  String get currencyChoice {
    return Intl.message(
      'Pound',
      name: 'currencyChoice',
      desc: '',
      args: [],
    );
  }

  /// `Units`
  String get units {
    return Intl.message(
      'Units',
      name: 'units',
      desc: '',
      args: [],
    );
  }

  /// `Meter Metric`
  String get unitsChoice {
    return Intl.message(
      'Meter Metric',
      name: 'unitsChoice',
      desc: '',
      args: [],
    );
  }

  /// `Temperature Scale`
  String get temperatureScale {
    return Intl.message(
      'Temperature Scale',
      name: 'temperatureScale',
      desc: '',
      args: [],
    );
  }

  /// `Celsius`
  String get C {
    return Intl.message(
      'Celsius',
      name: 'C',
      desc: '',
      args: [],
    );
  }

  /// `Outstanding`
  String get classificationOutstanding {
    return Intl.message(
      'Outstanding',
      name: 'classificationOutstanding',
      desc: '',
      args: [],
    );
  }

  /// `Wonderful`
  String get classificationWonderful {
    return Intl.message(
      'Wonderful',
      name: 'classificationWonderful',
      desc: '',
      args: [],
    );
  }

  /// `Good`
  String get classificationGood {
    return Intl.message(
      'Good',
      name: 'classificationGood',
      desc: '',
      args: [],
    );
  }

  /// `Pleasant`
  String get classificationPleasant {
    return Intl.message(
      'Pleasant',
      name: 'classificationPleasant',
      desc: '',
      args: [],
    );
  }

  /// `Not Very Good`
  String get classificationNotVeryGood {
    return Intl.message(
      'Not Very Good',
      name: 'classificationNotVeryGood',
      desc: '',
      args: [],
    );
  }

  /// `Disappointing`
  String get classificationDisappointing {
    return Intl.message(
      'Disappointing',
      name: 'classificationDisappointing',
      desc: '',
      args: [],
    );
  }

  /// `Terrible`
  String get classificationTerrible {
    return Intl.message(
      'Terrible',
      name: 'classificationTerrible',
      desc: '',
      args: [],
    );
  }

  /// `Not available rating`
  String get classificationError {
    return Intl.message(
      'Not available rating',
      name: 'classificationError',
      desc: '',
      args: [],
    );
  }

  /// `Popular Destinations`
  String get popularDest {
    return Intl.message(
      'Popular Destinations',
      name: 'popularDest',
      desc: 'HomePage title for Popular Destination Section',
      args: [],
    );
  }

  /// `Recommend Tours`
  String get recommendTours {
    return Intl.message(
      'Recommend Tours',
      name: 'recommendTours',
      desc: 'HomePage title for Recommend Tours Section',
      args: [],
    );
  }

  /// `Continue with`
  String get continueWith {
    return Intl.message(
      'Continue with',
      name: 'continueWith',
      desc: '',
      args: [],
    );
  }

  /// `Back to previous page`
  String get backToPreviousPage {
    return Intl.message(
      'Back to previous page',
      name: 'backToPreviousPage',
      desc: '',
      args: [],
    );
  }

  /// `Create your own tour`
  String get createTour {
    return Intl.message(
      'Create your own tour',
      name: 'createTour',
      desc: '',
      args: [],
    );
  }

  /// `image`
  String get image {
    return Intl.message(
      'image',
      name: 'image',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load image`
  String get errorImage {
    return Intl.message(
      'Failed to load image',
      name: 'errorImage',
      desc: '',
      args: [],
    );
  }

  /// `Image at {index}`
  String imageAtIndex(int index) {
    return Intl.message(
      'Image at $index',
      name: 'imageAtIndex',
      desc: '',
      args: [index],
    );
  }

  /// `Illustrators{nameOfCollection}`
  String imageCollectionText(String nameOfCollection) {
    return Intl.message(
      'Illustrators$nameOfCollection',
      name: 'imageCollectionText',
      desc:
          'Text for illustrators, optionally includes the name of illustrators',
      args: [nameOfCollection],
    );
  }

  /// `Loading image at index {index}`
  String loadingImageText(int index) {
    return Intl.message(
      'Loading image at index $index',
      name: 'loadingImageText',
      desc: 'Loading text for image at a specific position',
      args: [index],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `All Images and Videos`
  String get allImagesAndVideos {
    return Intl.message(
      'All Images and Videos',
      name: 'allImagesAndVideos',
      desc: '',
      args: [],
    );
  }

  /// `Review(s)`
  String get reviews {
    return Intl.message(
      'Review(s)',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Reviewed`
  String get reviewed {
    return Intl.message(
      'Reviewed',
      name: 'reviewed',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Ticket(s)`
  String get tickets {
    return Intl.message(
      'Ticket(s)',
      name: 'tickets',
      desc: '',
      args: [],
    );
  }

  /// `See`
  String get see {
    return Intl.message(
      'See',
      name: 'see',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get detail {
    return Intl.message(
      'Detail',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `Tour`
  String get tour {
    return Intl.message(
      'Tour',
      name: 'tour',
      desc: '',
      args: [],
    );
  }

  /// `Itinerary`
  String get itinerary {
    return Intl.message(
      'Itinerary',
      name: 'itinerary',
      desc: '',
      args: [],
    );
  }

  /// `Tour Schedule`
  String get tourSchedule {
    return Intl.message(
      'Tour Schedule',
      name: 'tourSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Tour Itinerary`
  String get tourItinerary {
    return Intl.message(
      'Tour Itinerary',
      name: 'tourItinerary',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get schedule {
    return Intl.message(
      'Schedule',
      name: 'schedule',
      desc: '',
      args: [],
    );
  }

  /// `Show More`
  String get showMore {
    return Intl.message(
      'Show More',
      name: 'showMore',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get services {
    return Intl.message(
      'Services',
      name: 'services',
      desc: '',
      args: [],
    );
  }

  /// `More Information`
  String get moreInfo {
    return Intl.message(
      'More Information',
      name: 'moreInfo',
      desc: '',
      args: [],
    );
  }

  /// `Outstanding Features`
  String get outStandingFeatures {
    return Intl.message(
      'Outstanding Features',
      name: 'outStandingFeatures',
      desc: '',
      args: [],
    );
  }

  /// `Transportation`
  String get transportation {
    return Intl.message(
      'Transportation',
      name: 'transportation',
      desc: 'Singular form of a transportation',
      args: [],
    );
  }

  /// `Additional Information`
  String get additionalInformation {
    return Intl.message(
      'Additional Information',
      name: 'additionalInformation',
      desc: '',
      args: [],
    );
  }

  /// `{value}`
  String totalReviews(int value) {
    final NumberFormat valueNumberFormat = NumberFormat.compact(
      locale: Intl.getCurrentLocale(),
    );
    final String valueString = valueNumberFormat.format(value);

    return Intl.message(
      '$valueString',
      name: 'totalReviews',
      desc: '',
      args: [valueString],
    );
  }

  /// `Duration`
  String get duration {
    return Intl.message(
      'Duration',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `day(s)`
  String get days {
    return Intl.message(
      'day(s)',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Day {value}`
  String scheduleDay(int value) {
    return Intl.message(
      'Day $value',
      name: 'scheduleDay',
      desc: '',
      args: [value],
    );
  }

  /// `Tour Description Detail`
  String get tourDescDetail {
    return Intl.message(
      'Tour Description Detail',
      name: 'tourDescDetail',
      desc: '',
      args: [],
    );
  }

  /// `Location Information`
  String get locationInfo {
    return Intl.message(
      'Location Information',
      name: 'locationInfo',
      desc: '',
      args: [],
    );
  }

  /// `Guide to location`
  String get guideToLocation {
    return Intl.message(
      'Guide to location',
      name: 'guideToLocation',
      desc: '',
      args: [],
    );
  }

  /// `All Photos`
  String get allPhotos {
    return Intl.message(
      'All Photos',
      name: 'allPhotos',
      desc: '',
      args: [],
    );
  }

  /// `Could not make the phone call`
  String get makeCallFailure {
    return Intl.message(
      'Could not make the phone call',
      name: 'makeCallFailure',
      desc: '',
      args: [],
    );
  }

  /// `Contact service provider`
  String get contactServiceProvider {
    return Intl.message(
      'Contact service provider',
      name: 'contactServiceProvider',
      desc: '',
      args: [],
    );
  }

  /// `For more details about this ticket`
  String get forMoreInfoAboutTicket {
    return Intl.message(
      'For more details about this ticket',
      name: 'forMoreInfoAboutTicket',
      desc: '',
      args: [],
    );
  }

  /// `see here`
  String get seeHere {
    return Intl.message(
      'see here',
      name: 'seeHere',
      desc: '',
      args: [],
    );
  }

  /// `Thumb for {name}`
  String thumbDesc(String name) {
    return Intl.message(
      'Thumb for $name',
      name: 'thumbDesc',
      desc: 'Thumbnail for an image',
      args: [name],
    );
  }

  /// `Voucher can be used on`
  String get voucherCanBeUsedOn {
    return Intl.message(
      'Voucher can be used on',
      name: 'voucherCanBeUsedOn',
      desc: '',
      args: [],
    );
  }

  /// `Add Visitor Number`
  String get addVisitorNumber {
    return Intl.message(
      'Add Visitor Number',
      name: 'addVisitorNumber',
      desc: '',
      args: [],
    );
  }

  /// `Important things you should know`
  String get importantThingsYouShouldKnow {
    return Intl.message(
      'Important things you should know',
      name: 'importantThingsYouShouldKnow',
      desc: '',
      args: [],
    );
  }

  /// `Buy Ticket`
  String get buyTicket {
    return Intl.message(
      'Buy Ticket',
      name: 'buyTicket',
      desc: '',
      args: [],
    );
  }

  /// `About this ticket`
  String get aboutThisTicket {
    return Intl.message(
      'About this ticket',
      name: 'aboutThisTicket',
      desc: '',
      args: [],
    );
  }

  /// `Voucher Expiration`
  String get voucherExp {
    return Intl.message(
      'Voucher Expiration',
      name: 'voucherExp',
      desc: '',
      args: [],
    );
  }

  /// `selected date`
  String get selectedDate {
    return Intl.message(
      'selected date',
      name: 'selectedDate',
      desc: '',
      args: [],
    );
  }

  /// `Redemption Method`
  String get redemptionMethod {
    return Intl.message(
      'Redemption Method',
      name: 'redemptionMethod',
      desc: '',
      args: [],
    );
  }

  /// `How to redeem`
  String get howToRedeem {
    return Intl.message(
      'How to redeem',
      name: 'howToRedeem',
      desc: '',
      args: [],
    );
  }

  /// `Can be Rescheduled`
  String get canBeRescheduled {
    return Intl.message(
      'Can be Rescheduled',
      name: 'canBeRescheduled',
      desc: '',
      args: [],
    );
  }

  /// `Cannot be Rescheduled`
  String get cannotBeRescheduled {
    return Intl.message(
      'Cannot be Rescheduled',
      name: 'cannotBeRescheduled',
      desc: '',
      args: [],
    );
  }

  /// `Can be refund`
  String get refundable {
    return Intl.message(
      'Can be refund',
      name: 'refundable',
      desc: '',
      args: [],
    );
  }

  /// `Cannot be refund`
  String get nonRefundable {
    return Intl.message(
      'Cannot be refund',
      name: 'nonRefundable',
      desc: '',
      args: [],
    );
  }

  /// `Refund & Reschedule`
  String get refundAndReschedule {
    return Intl.message(
      'Refund & Reschedule',
      name: 'refundAndReschedule',
      desc: '',
      args: [],
    );
  }

  /// `For {ticketType}`
  String forType(String ticketType) {
    return Intl.message(
      'For $ticketType',
      name: 'forType',
      desc: '',
      args: [ticketType],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Total Price`
  String get totalPrice {
    return Intl.message(
      'Total Price',
      name: 'totalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Inclusive of taxes and fees`
  String get paymentInfo {
    return Intl.message(
      'Inclusive of taxes and fees',
      name: 'paymentInfo',
      desc: '',
      args: [],
    );
  }

  /// `Booking Now`
  String get bookingNow {
    return Intl.message(
      'Booking Now',
      name: 'bookingNow',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signIn {
    return Intl.message(
      'Sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `We are going to sign in with your email or create a new account if you don't have one`
  String get emailAnnouncement {
    return Intl.message(
      'We are going to sign in with your email or create a new account if you don\'t have one',
      name: 'emailAnnouncement',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get enterPasswordRequirement {
    return Intl.message(
      'Please enter your password',
      name: 'enterPasswordRequirement',
      desc: '',
      args: [],
    );
  }

  /// `Password must have at least 8 characters, 1 uppercase, 1 lowercase, 1 number and 1 special character`
  String get passwordRequirement {
    return Intl.message(
      'Password must have at least 8 characters, 1 uppercase, 1 lowercase, 1 number and 1 special character',
      name: 'passwordRequirement',
      desc: '',
      args: [],
    );
  }

  /// `Enter your country name or code to search`
  String get phoneSearchHintText {
    return Intl.message(
      'Enter your country name or code to search',
      name: 'phoneSearchHintText',
      desc: '',
      args: [],
    );
  }

  /// `Maximum length of phone number`
  String get semanticPhoneNumberCounterText {
    return Intl.message(
      'Maximum length of phone number',
      name: 'semanticPhoneNumberCounterText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get enterPhoneNumberRequirement {
    return Intl.message(
      'Please enter your phone number',
      name: 'enterPhoneNumberRequirement',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get invalidPhoneNumber {
    return Intl.message(
      'Invalid phone number',
      name: 'invalidPhoneNumber',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
