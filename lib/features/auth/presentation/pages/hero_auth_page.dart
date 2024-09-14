import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../widgets/about_section.dart';
import '../widgets/hero_image.dart';
import '../widgets/setting_icon.dart';

class HeroAuthPage extends StatefulWidget {
  const HeroAuthPage({super.key});

  @override
  State<HeroAuthPage> createState() => _HeroAuthPageState();
}

class _HeroAuthPageState extends State<HeroAuthPage> {
  @override
  Widget build(BuildContext context) {
    const SizedBox spacing = SizedBox(height: 10);

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: const <Widget>[
          SettingIcon(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _buildInfoSection(),
            spacing,
            const AboutSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    const SizedBox spacing = SizedBox(height: 15);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const HeroImage(),
            spacing,
            _buildPromotionText(),
            spacing,
            _buildAuthButton(),
          ],
        ),
      ),
    );
  }

  Text _buildPromotionText() {
    return const Text(
      'Exclusive Offers for you - with only one simple step!',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      semanticsLabel: 'Exclusive Offers for you - with only simple step!',
      textAlign: TextAlign.center,
      textDirection: defaultTextDirection,
    );
  }

  Widget _buildAuthButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        child: const Text(
          'Sign in/Sign up',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
