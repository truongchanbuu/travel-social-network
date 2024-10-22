import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_social_network/features/auth/presentations/pages/continue_with_phone_page.dart';

void main() {
  testWidgets(
    'AppBar should have a back button and have white color',
    (widgetTester) async {
      await widgetTester.pumpWidget(const ContinueWithPhonePage());

      Finder appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOne,
          reason: 'Expected an app bar in the screen');

      AppBar appBar = widgetTester.widget<AppBar>(appBarFinder);
      expect(appBar.backgroundColor, Colors.white,
          reason: 'Expected a white app bar');

      Finder iconButtonFinder = find.descendant(
          of: appBarFinder,
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is IconButton &&
                widget.icon is Icon &&
                (widget as Icon).icon == Icons.chevron_left,
          ));
      expect(iconButtonFinder, findsOne,
          reason:
              'Expected an Icon which can be tapped and have chevron left symbol');
    },
  );

  testWidgets(
    'There are 2 text inputs',
    (widgetTester) async {
      await widgetTester.pumpWidget(const ContinueWithPhonePage());

      Finder textInputFinder = find.byType(TextFormField);
      expect(textInputFinder, findsExactly(2));
    },
  );

  testWidgets(
    'Phone Number Input',
    (widgetTester) async {
      await widgetTester.pumpWidget(const ContinueWithPhonePage());

      Finder phoneNumberLabel = find.text('Phone number');
      expect(phoneNumberLabel, findsOne,
          reason: 'Expected a label for phone number');

      Finder phoneFieldFinder = find.bySemanticsLabel('Phone number');

      Finder errorMessageText = find.text('Please enter an valid phone number');

      await widgetTester.enterText(phoneFieldFinder, '123abc');
      await widgetTester.pump();
      expect(errorMessageText, findsOneWidget,
          reason: 'Expected a error message for wrong phone number');

      await widgetTester.enterText(phoneFieldFinder, '0123456789');
      await widgetTester.pump();
      expect(errorMessageText, findsNothing,
          reason: 'Expected no errors are shown');
    },
  );

  testWidgets(
    'Password Input',
    (widgetTester) async {
      await widgetTester.pumpWidget(const ContinueWithPhonePage());
      Finder phoneNumberLabel = find.text('Password');
      expect(phoneNumberLabel, findsOne,
          reason: 'Expected a label for password');

      Finder errorMessageText = find.text(
          'Password should have at least 8 character, 1 uppercase, 1 lowercase, 1 special character');
      Finder passwordFieldFinder = find.bySemanticsLabel('Password');

      await widgetTester.enterText(passwordFieldFinder, '123456');
      await widgetTester.pump();
      expect(errorMessageText, findsOne, reason: 'Expected a error message');

      await widgetTester.enterText(passwordFieldFinder, 'Abc@123456');
      await widgetTester.pump();
      expect(errorMessageText, findsNothing,
          reason: 'Expected nothing is shown');
    },
  );

  testWidgets(
    'Forgot Password Text',
    (widgetTester) async {
      await widgetTester.pumpWidget(const ContinueWithPhonePage());
      Finder forgotPasswordTextFinder = find.text('Forgot Password?');

      expect(forgotPasswordTextFinder, findsOne);
      Text forgotPasswordText = widgetTester.widget(forgotPasswordTextFinder);
      expect(forgotPasswordText.style?.color, Colors.blue);
    },
  );

  testWidgets(
    'There is button with "Continue" text and chevron right icon',
    (widgetTester) async {
      await widgetTester.pumpWidget(const ContinueWithPhonePage());

      Finder buttonFinder = find.widgetWithText(ElevatedButton, 'Continue');
      expect(buttonFinder, findsOne,
          reason: 'Expected a button with "Continue" text');

      Finder chevronRightIconFinder = find.descendant(
          of: buttonFinder, matching: find.byIcon(Icons.chevron_right));
      expect(chevronRightIconFinder, findsOne,
          reason: 'Expected an chevron right icon');
    },
  );
}
