import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_social_network/cores/constants/constants.dart';
import 'package:travel_social_network/features/auth/presentation/pages/authentication/hero_auth_page.dart';

void main() {
  testWidgets(
    'Widget has indigo app bar with a back button (chevron left)',
    (widgetTester) async {
      await widgetTester.pumpWidget(const HeroAuthPage());

      final appBarFinder = find.byWidget(AppBar());
      final appBar = widgetTester.widget(appBarFinder) as AppBar;

      expect(appBarFinder, findsOneWidget, reason: 'There must be an App bar');
      expect(appBar.backgroundColor, primaryColor,
          reason: 'App Bar must be $primaryColor');

      final chevronFinder = find.byIcon(Icons.chevron_left);
      expect(chevronFinder, findsOneWidget);

      final backBtnIcon = widgetTester.widget(chevronFinder) as Icon;
      expect(backBtnIcon.color, Colors.white,
          reason: 'The back button should white');
    },
  );

  testWidgets(
    'Widget has an app bar with app name [Traveround.com],'
    ' which [Traveround] is ưhite and [.com] is yellow',
    (widgetTester) async {
      await widgetTester.pumpWidget(const HeroAuthPage());

      final appNameFirstPart = find.widgetWithText(TextSpan, 'Traveround');
      final appNameSecondPart = find.widgetWithText(TextSpan, '.com');

      expect(appNameFirstPart, findsOneWidget,
          reason: '[Traveround] does not found');
      expect(appNameSecondPart, findsOneWidget,
          reason: '[.com] does not found');

      final firstTextSpan = widgetTester.widget(appNameFirstPart) as TextSpan;
      final secondTextSpan = widgetTester.widget(appNameSecondPart) as TextSpan;

      expect(firstTextSpan.style?.color, appNameLogoPrimaryColor,
          reason: 'The [Traveround] color must be white');
      expect(secondTextSpan.style?.color, appNameLogoSecondaryColor,
          reason: 'The [.com] color must be yellow');
    },
  );

  testWidgets(
    'Widget has hero image',
    (widgetTester) async {
      await widgetTester.pumpWidget(const HeroAuthPage());

      final heroImageFinder = find.byType(Image);

      expect(heroImageFinder, findsOneWidget,
          reason: 'The hero image does not found');

      final heroImageWidget = widgetTester.widget(heroImageFinder) as Image;
      expect(heroImageWidget.image, isA<AssetImage>(),
          reason: 'The image identifier may be not correct or not available');

      final assetImage = heroImageWidget.image as AssetImage;
      expect(assetImage.assetName, 'assets/hero-auth.png',
          reason: 'The image may be not available or not correct');
    },
  );

  testWidgets(
    'Widget has a desc',
    (widgetTester) async {
      const textColor = Colors.grey;

      await widgetTester.pumpWidget(const HeroAuthPage());

      final iconFinder = find.byType(Icon);
      expect(iconFinder, findsOneWidget, reason: 'Expected a icon here');

      final iconWidget = widgetTester.widget(iconFinder) as Icon;
      expect(iconWidget.icon, Icons.discount_outlined,
          reason: 'Expected a discount icon');
      expect(iconWidget.color, textColor,
          reason: 'Expected a $textColor color for the icon');

      final descTextFinder = find.text('Enjoy the privilege of membership');
      expect(descTextFinder, findsOne,
          reason: 'Expected the text: "Enjoy the privilege of membership"');

      final descTextWidget = widgetTester.widget(descTextFinder) as Text;
      expect(descTextWidget.style?.color, textColor,
          reason: 'Expected a $textColor text');
    },
  );

  testWidgets(
    'Widget has a container which has box shadow and has top border',
    (widgetTester) async {
      await widgetTester.pumpWidget(const HeroAuthPage());

      final materialContainerFinder = find.byWidget(const Material());
      expect(materialContainerFinder, findsOneWidget,
          reason: 'Expected a Material contains for the text here');

      final materialContainer =
          widgetTester.widget(materialContainerFinder) as Material;
      final shapeBorder = materialContainer.shape as Border;
      expect(shapeBorder.top, isNotNull, reason: 'Expected a top border');
      expect(shapeBorder.top.color, Colors.black,
          reason: 'Expected a black top border');
      expect(shapeBorder.top.width, 2.0,
          reason: 'Expected top border width to be 2.0.');

      final elevation = materialContainer.elevation;
      expect(elevation, isNotNull, reason: 'Expected drop shadow here');
      expect(elevation, 2.0, reason: 'Expected the width of elevation is 2.0');
    },
  );

  testWidgets(
    'Widget must have Term of Condition and Private Policy',
    (widgetTester) async {
      await widgetTester.pumpWidget(const HeroAuthPage());

      final textFinder = find.text(
          'By creating an account, you agree to our Terms of Service and Privacy Policy');
      expect(textFinder, findsOne,
          reason:
              'Expected a Term of Condition and Private Policy announcement');

      final termOfServiceTextFinder = find.text('Terms of Service');
      final termOfServiceText =
          widgetTester.widget(termOfServiceTextFinder) as TextSpan;
      expect(termOfServiceText.style?.fontWeight, FontWeight.bold,
          reason: 'Expected the text "Term of Service" to be bold');
      expect(termOfServiceText.style?.color, Colors.blue,
          reason: 'Expected the text "Term of Service" to be blue');

      final privatePolicyTextFinder = find.text('Private Policy');
      final privatePolicyText =
          widgetTester.widget(privatePolicyTextFinder) as TextSpan;
      expect(privatePolicyText.style?.fontWeight, FontWeight.bold,
          reason: 'Expected the text "Private Policy" to be bold');
      expect(privatePolicyText.style?.color, Colors.blue,
          reason: 'Expected the text "Private Policy" to be blue');
    },
  );
}
