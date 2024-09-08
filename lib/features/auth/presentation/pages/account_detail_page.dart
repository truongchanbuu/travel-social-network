import 'package:flutter/material.dart';

import '../widgets/account_detail_section.dart';

class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [],
      ),
    );
  }

  Widget _buildSecuritySection() {
    return const Column(
      children: [
        AccountDetailSection(title: 'Account Security'),
      ],
    );
  }
}
