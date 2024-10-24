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

  /// `Here`
  String get here {
    return Intl.message(
      'Here',
      name: 'here',
      desc: '',
      args: [],
    );
  }

  /// `Like`
  String get like {
    return Intl.message(
      'Like',
      name: 'like',
      desc: '',
      args: [],
    );
  }

  /// `Reply`
  String get reply {
    return Intl.message(
      'Reply',
      name: 'reply',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
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

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get shareLabel {
    return Intl.message(
      'Share',
      name: 'shareLabel',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0 {Share} =1 {Share} other{Shares}}`
  String share(num count) {
    return Intl.plural(
      count,
      zero: 'Share',
      one: 'Share',
      other: 'Shares',
      name: 'share',
      desc: '',
      args: [count],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get post {
    return Intl.message(
      'Post',
      name: 'post',
      desc: '',
      args: [],
    );
  }

  /// `Emotion`
  String get emotion {
    return Intl.message(
      'Emotion',
      name: 'emotion',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueLabel {
    return Intl.message(
      'Continue',
      name: 'continueLabel',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get stop {
    return Intl.message(
      'Stop',
      name: 'stop',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Stay`
  String get stay {
    return Intl.message(
      'Stay',
      name: 'stay',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get leave {
    return Intl.message(
      'Leave',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get commentLabel {
    return Intl.message(
      'Comment',
      name: 'commentLabel',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0{Comment} =1{Comment} other{Comments}}`
  String comment(num count) {
    return Intl.plural(
      count,
      zero: 'Comment',
      one: 'Comment',
      other: 'Comments',
      name: 'comment',
      desc: '',
      args: [count],
    );
  }

  /// `Not Found`
  String get notFound {
    return Intl.message(
      'Not Found',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `Searching...`
  String get searching {
    return Intl.message(
      'Searching...',
      name: 'searching',
      desc: '',
      args: [],
    );
  }

  /// `hour`
  String get hour {
    return Intl.message(
      'hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get day {
    return Intl.message(
      'day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `week`
  String get week {
    return Intl.message(
      'week',
      name: 'week',
      desc: '',
      args: [],
    );
  }

  /// `month`
  String get month {
    return Intl.message(
      'month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get year {
    return Intl.message(
      'year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get minute {
    return Intl.message(
      'minute',
      name: 'minute',
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

  /// `Hello {name},`
  String helloUser(String name) {
    return Intl.message(
      'Hello $name,',
      name: 'helloUser',
      desc: '',
      args: [name],
    );
  }

  /// `Good morning! Ready for today's adventures?`
  String get morningText {
    return Intl.message(
      'Good morning! Ready for today\'s adventures?',
      name: 'morningText',
      desc: '',
      args: [],
    );
  }

  /// `Let discover top spots and activities!!!`
  String get afternoonText {
    return Intl.message(
      'Let discover top spots and activities!!!',
      name: 'afternoonText',
      desc: '',
      args: [],
    );
  }

  /// `It's time for special dishes on elegant restaurants near you!`
  String get eveningText {
    return Intl.message(
      'It\'s time for special dishes on elegant restaurants near you!',
      name: 'eveningText',
      desc: '',
      args: [],
    );
  }

  /// `Have a nice sleep! Dreams are beginning but tomorrow journey will come true`
  String get nightText {
    return Intl.message(
      'Have a nice sleep! Dreams are beginning but tomorrow journey will come true',
      name: 'nightText',
      desc: '',
      args: [],
    );
  }

  /// `Hope you doing well on your own journey`
  String get defaultText {
    return Intl.message(
      'Hope you doing well on your own journey',
      name: 'defaultText',
      desc: '',
      args: [],
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

  /// `Create New Tour`
  String get createTourPageTitle {
    return Intl.message(
      'Create New Tour',
      name: 'createTourPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `There are still no tours here!`
  String get noTours {
    return Intl.message(
      'There are still no tours here!',
      name: 'noTours',
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

  /// `Add Images`
  String get addImageLabel {
    return Intl.message(
      'Add Images',
      name: 'addImageLabel',
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

  /// `{prefix}-img-{index}`
  String cacheKeyWithId(String prefix, int index) {
    return Intl.message(
      '$prefix-img-$index',
      name: 'cacheKeyWithId',
      desc: '',
      args: [prefix, index],
    );
  }

  /// `{imgUrl}-{index}`
  String cacheKeyWithoutId(String imgUrl, int index) {
    return Intl.message(
      '$imgUrl-$index',
      name: 'cacheKeyWithoutId',
      desc: '',
      args: [imgUrl, index],
    );
  }

  /// `Image {name} failed to add`
  String addImageFailure(String name) {
    return Intl.message(
      'Image $name failed to add',
      name: 'addImageFailure',
      desc: '',
      args: [name],
    );
  }

  /// `Reviews & Rating`
  String get reviewTitle {
    return Intl.message(
      'Reviews & Rating',
      name: 'reviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, zero{Review} one{Review} other {Reviews}}`
  String reviews(num count) {
    return Intl.plural(
      count,
      zero: 'Review',
      one: 'Review',
      other: 'Reviews',
      name: 'reviews',
      desc: '',
      args: [count],
    );
  }

  /// `There are still no reviews! Let become the first one for this tour!`
  String get noReviews {
    return Intl.message(
      'There are still no reviews! Let become the first one for this tour!',
      name: 'noReviews',
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

  /// `Rate Your Experience`
  String get rateYourExperience {
    return Intl.message(
      'Rate Your Experience',
      name: 'rateYourExperience',
      desc: '',
      args: [],
    );
  }

  /// `Tap to rate`
  String get tapToRate {
    return Intl.message(
      'Tap to rate',
      name: 'tapToRate',
      desc: '',
      args: [],
    );
  }

  /// `Write your review here...`
  String get reviewHint {
    return Intl.message(
      'Write your review here...',
      name: 'reviewHint',
      desc: '',
      args: [],
    );
  }

  /// `The review has been deleted`
  String get reviewDeleted {
    return Intl.message(
      'The review has been deleted',
      name: 'reviewDeleted',
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

  /// `There are no tickets!`
  String get noTickets {
    return Intl.message(
      'There are no tickets!',
      name: 'noTickets',
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

  /// `My Tours`
  String get myTour {
    return Intl.message(
      'My Tours',
      name: 'myTour',
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

  /// `Editor Page`
  String get editPage {
    return Intl.message(
      'Editor Page',
      name: 'editPage',
      desc: '',
      args: [],
    );
  }

  /// `Add your tour description here...`
  String get editingPlaceholderText {
    return Intl.message(
      'Add your tour description here...',
      name: 'editingPlaceholderText',
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

  /// `Show Less`
  String get showLess {
    return Intl.message(
      'Show Less',
      name: 'showLess',
      desc: '',
      args: [],
    );
  }

  /// `More Action`
  String get moreAction {
    return Intl.message(
      'More Action',
      name: 'moreAction',
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

  /// `{value, plural, =0{0 review} =1{1 review} other{{formattedValue} reviews}}`
  String totalReviews(int value, String formattedValue) {
    return Intl.plural(
      value,
      zero: '0 review',
      one: '1 review',
      other: '$formattedValue reviews',
      name: 'totalReviews',
      desc: '',
      args: [value, formattedValue],
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

  /// `Create Ticket`
  String get createTicket {
    return Intl.message(
      'Create Ticket',
      name: 'createTicket',
      desc: '',
      args: [],
    );
  }

  /// `Failed to create ticket(s)`
  String get createTicketError {
    return Intl.message(
      'Failed to create ticket(s)',
      name: 'createTicketError',
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

  /// `refund`
  String get refund {
    return Intl.message(
      'refund',
      name: 'refund',
      desc: '',
      args: [],
    );
  }

  /// `reschedule`
  String get reschedule {
    return Intl.message(
      'reschedule',
      name: 'reschedule',
      desc: '',
      args: [],
    );
  }

  /// `Easy to refund`
  String get easyToRefund {
    return Intl.message(
      'Easy to refund',
      name: 'easyToRefund',
      desc: '',
      args: [],
    );
  }

  /// `Easy to reschedule`
  String get easyToReschedule {
    return Intl.message(
      'Easy to reschedule',
      name: 'easyToReschedule',
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

  /// `Refund Policy`
  String get refundPolicy {
    return Intl.message(
      'Refund Policy',
      name: 'refundPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Reschedule Policy`
  String get reschedulePolicy {
    return Intl.message(
      'Reschedule Policy',
      name: 'reschedulePolicy',
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

  /// `6 hours, 1 day, 2 weeks, 3 months, ...`
  String get durationHintText {
    return Intl.message(
      '6 hours, 1 day, 2 weeks, 3 months, ...',
      name: 'durationHintText',
      desc: '',
      args: [],
    );
  }

  /// `Invalid duration`
  String get invalidDurationError {
    return Intl.message(
      'Invalid duration',
      name: 'invalidDurationError',
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
  String get invalidPhoneNumberError {
    return Intl.message(
      'Invalid phone number',
      name: 'invalidPhoneNumberError',
      desc: '',
      args: [],
    );
  }

  /// `Recent Search`
  String get recentSearch {
    return Intl.message(
      'Recent Search',
      name: 'recentSearch',
      desc: '',
      args: [],
    );
  }

  /// `Recommendations`
  String get recommendation {
    return Intl.message(
      'Recommendations',
      name: 'recommendation',
      desc: '',
      args: [],
    );
  }

  /// `Tour Name`
  String get tourNameLabel {
    return Intl.message(
      'Tour Name',
      name: 'tourNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Tour Description`
  String get tourDescLabel {
    return Intl.message(
      'Tour Description',
      name: 'tourDescLabel',
      desc: '',
      args: [],
    );
  }

  /// `Tour Details`
  String get tourDetails {
    return Intl.message(
      'Tour Details',
      name: 'tourDetails',
      desc: '',
      args: [],
    );
  }

  /// `Destination`
  String get destination {
    return Intl.message(
      'Destination',
      name: 'destination',
      desc: '',
      args: [],
    );
  }

  /// `Invalid destination! Please choose or insert a valid destination`
  String get invalidDestinationError {
    return Intl.message(
      'Invalid destination! Please choose or insert a valid destination',
      name: 'invalidDestinationError',
      desc: '',
      args: [],
    );
  }

  /// `Departure`
  String get departure {
    return Intl.message(
      'Departure',
      name: 'departure',
      desc: '',
      args: [],
    );
  }

  /// `Invalid departure location! Please choose or insert a valid location`
  String get invalidDepartureError {
    return Intl.message(
      'Invalid departure location! Please choose or insert a valid location',
      name: 'invalidDepartureError',
      desc: '',
      args: [],
    );
  }

  /// `Discard unsaved work`
  String get discardUnsavedWork {
    return Intl.message(
      'Discard unsaved work',
      name: 'discardUnsavedWork',
      desc: '',
      args: [],
    );
  }

  /// `Are you want to leave without saving?`
  String get discardAlertMessage {
    return Intl.message(
      'Are you want to leave without saving?',
      name: 'discardAlertMessage',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete?`
  String get deleteConfirmTitle {
    return Intl.message(
      'Are you sure to delete?',
      name: 'deleteConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Delete cannot be undone anymore`
  String get deleteConfirmText {
    return Intl.message(
      'Delete cannot be undone anymore',
      name: 'deleteConfirmText',
      desc: '',
      args: [],
    );
  }

  /// `Tour Dates`
  String get tourDatesLabel {
    return Intl.message(
      'Tour Dates',
      name: 'tourDatesLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add Date`
  String get addDate {
    return Intl.message(
      'Add Date',
      name: 'addDate',
      desc: '',
      args: [],
    );
  }

  /// `Start date and end date cannot be same`
  String get sameDateError {
    return Intl.message(
      'Start date and end date cannot be same',
      name: 'sameDateError',
      desc: '',
      args: [],
    );
  }

  /// `Your trip will start at: {start} and accomplish at: {end}`
  String tourDateAnnounce(DateTime start, DateTime end) {
    final DateFormat startDateFormat =
        DateFormat('HH:mm \'in\' EEE, dd MM yyyy', Intl.getCurrentLocale());
    final String startString = startDateFormat.format(start);

    final DateFormat endDateFormat =
        DateFormat('HH:mm \'in\' EEE, dd MM yyyy', Intl.getCurrentLocale());
    final String endString = endDateFormat.format(end);

    return Intl.message(
      'Your trip will start at: $startString and accomplish at: $endString',
      name: 'tourDateAnnounce',
      desc: '',
      args: [startString, endString],
    );
  }

  /// `Cannot select in use date`
  String get inUseDateError {
    return Intl.message(
      'Cannot select in use date',
      name: 'inUseDateError',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Name`
  String get ticketName {
    return Intl.message(
      'Ticket Name',
      name: 'ticketName',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Category`
  String get ticketCategory {
    return Intl.message(
      'Ticket Category',
      name: 'ticketCategory',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Description`
  String get ticketDesc {
    return Intl.message(
      'Ticket Description',
      name: 'ticketDesc',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Info`
  String get ticketInfo {
    return Intl.message(
      'Ticket Info',
      name: 'ticketInfo',
      desc: '',
      args: [],
    );
  }

  /// `Redemption Method`
  String get ticketRedemption {
    return Intl.message(
      'Redemption Method',
      name: 'ticketRedemption',
      desc: '',
      args: [],
    );
  }

  /// `Policy Name`
  String get policyName {
    return Intl.message(
      'Policy Name',
      name: 'policyName',
      desc: '',
      args: [],
    );
  }

  /// `Policy Description`
  String get policyDesc {
    return Intl.message(
      'Policy Description',
      name: 'policyDesc',
      desc: '',
      args: [],
    );
  }

  /// `Invalid {field}! It must be at least {minLength} characters`
  String lengthLimitError(String field, int minLength) {
    return Intl.message(
      'Invalid $field! It must be at least $minLength characters',
      name: 'lengthLimitError',
      desc: '',
      args: [field, minLength],
    );
  }

  /// `Not allowed to be empty`
  String get notAllowedEmpty {
    return Intl.message(
      'Not allowed to be empty',
      name: 'notAllowedEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Form! Do not empty any fields or necessary information`
  String get invalidForm {
    return Intl.message(
      'Invalid Form! Do not empty any fields or necessary information',
      name: 'invalidForm',
      desc: '',
      args: [],
    );
  }

  /// `Duplicate Ticket`
  String get duplicateTicketAlert {
    return Intl.message(
      'Duplicate Ticket',
      name: 'duplicateTicketAlert',
      desc: '',
      args: [],
    );
  }

  /// `There are duplicated ticket(s)! Are you want to continue creating without duplicated ticket(s)? You can modify the duplicated ticket(s) later in section My Tour`
  String get duplicateTicketMessage {
    return Intl.message(
      'There are duplicated ticket(s)! Are you want to continue creating without duplicated ticket(s)? You can modify the duplicated ticket(s) later in section My Tour',
      name: 'duplicateTicketMessage',
      desc: '',
      args: [],
    );
  }

  /// `The location cannot be same`
  String get duplicateLocation {
    return Intl.message(
      'The location cannot be same',
      name: 'duplicateLocation',
      desc: '',
      args: [],
    );
  }

  /// `Ticket List`
  String get ticketList {
    return Intl.message(
      'Ticket List',
      name: 'ticketList',
      desc: '',
      args: [],
    );
  }

  /// `Cannot save the {object}! Please try again later`
  String saveError(String object) {
    return Intl.message(
      'Cannot save the $object! Please try again later',
      name: 'saveError',
      desc: '',
      args: [object],
    );
  }

  /// `Is Allow`
  String get isAllow {
    return Intl.message(
      'Is Allow',
      name: 'isAllow',
      desc: '',
      args: [],
    );
  }

  /// `year|years|y`
  String get yearUnit {
    return Intl.message(
      'year|years|y',
      name: 'yearUnit',
      desc: '',
      args: [],
    );
  }

  /// `month|months|mo`
  String get monthUnit {
    return Intl.message(
      'month|months|mo',
      name: 'monthUnit',
      desc: '',
      args: [],
    );
  }

  /// `week|weeks|w`
  String get weekUnit {
    return Intl.message(
      'week|weeks|w',
      name: 'weekUnit',
      desc: '',
      args: [],
    );
  }

  /// `day|days|d`
  String get dayUnit {
    return Intl.message(
      'day|days|d',
      name: 'dayUnit',
      desc: '',
      args: [],
    );
  }

  /// `hour|hours|h`
  String get hourUnit {
    return Intl.message(
      'hour|hours|h',
      name: 'hourUnit',
      desc: '',
      args: [],
    );
  }

  /// `minute|minutes|min`
  String get minuteUnit {
    return Intl.message(
      'minute|minutes|min',
      name: 'minuteUnit',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =1{1 year} other{{count} years}}`
  String yearFormatted(num count) {
    return Intl.plural(
      count,
      one: '1 year',
      other: '$count years',
      name: 'yearFormatted',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 month} other{{count} months}}`
  String monthFormatted(num count) {
    return Intl.plural(
      count,
      one: '1 month',
      other: '$count months',
      name: 'monthFormatted',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 week} other{{count} weeks}}`
  String weekFormatted(num count) {
    return Intl.plural(
      count,
      one: '1 week',
      other: '$count weeks',
      name: 'weekFormatted',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 day} other{{count} days}}`
  String dayFormatted(num count) {
    return Intl.plural(
      count,
      one: '1 day',
      other: '$count days',
      name: 'dayFormatted',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 hour} other{{count} hours}}`
  String hourFormatted(num count) {
    return Intl.plural(
      count,
      one: '1 hour',
      other: '$count hours',
      name: 'hourFormatted',
      desc: '',
      args: [count],
    );
  }

  /// `{count, plural, =1{1 minute} other{{count} minutes}}`
  String minuteFormatted(num count) {
    return Intl.plural(
      count,
      one: '1 minute',
      other: '$count minutes',
      name: 'minuteFormatted',
      desc: '',
      args: [count],
    );
  }

  /// `Some error occurred! Please try again later!`
  String get dataStateFailure {
    return Intl.message(
      'Some error occurred! Please try again later!',
      name: 'dataStateFailure',
      desc: '',
      args: [],
    );
  }

  /// `Invalid file type. Only images are allowed`
  String get invalidImageFileType {
    return Intl.message(
      'Invalid file type. Only images are allowed',
      name: 'invalidImageFileType',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported image format`
  String get unsupportedImageFormat {
    return Intl.message(
      'Unsupported image format',
      name: 'unsupportedImageFormat',
      desc: '',
      args: [],
    );
  }

  /// `Failed to fetch image from URL`
  String get fetchDataFailure {
    return Intl.message(
      'Failed to fetch image from URL',
      name: 'fetchDataFailure',
      desc: '',
      args: [],
    );
  }

  /// `How are you feeling today?`
  String get howYourFeeling {
    return Intl.message(
      'How are you feeling today?',
      name: 'howYourFeeling',
      desc: '',
      args: [],
    );
  }

  /// `Create Post`
  String get createPost {
    return Intl.message(
      'Create Post',
      name: 'createPost',
      desc: '',
      args: [],
    );
  }

  /// `What do you think about this post?`
  String get whatYouThinkAboutThisPost {
    return Intl.message(
      'What do you think about this post?',
      name: 'whatYouThinkAboutThisPost',
      desc: '',
      args: [],
    );
  }

  /// `Please login to share your feeling with everyone`
  String get postNoLoginText {
    return Intl.message(
      'Please login to share your feeling with everyone',
      name: 'postNoLoginText',
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
