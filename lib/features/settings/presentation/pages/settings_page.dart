import 'package:flutter/material.dart';

import '../widgets/switch_setting_item.dart';
import '../widgets/multiple_choice_setting_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Settings'),
        shape: const Border(
          bottom: BorderSide(
            width: 0.5,
            color: Colors.grey,
          ),
        ),
      ),
      body: ListView(
        children: [
          _buildMultipleChoiceSection(),
          const Divider(),
          _buildSwitchSelection(),
          const Divider(),
          _buildAdditionalSection(),
        ],
      ),
    );
  }

  Widget _buildMultipleChoiceSection() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: const Column(
        children: [
          MultipleChoiceSettingItem(title: 'Language', choice: 'English'),
          MultipleChoiceSettingItem(title: 'Country/Region', choice: 'England'),
          MultipleChoiceSettingItem(title: 'Currency', choice: 'Pound'),
          MultipleChoiceSettingItem(title: 'Units', choice: 'Meter Metric'),
          MultipleChoiceSettingItem(
              title: 'Temperature Scale', choice: 'Celsius'),
        ],
      ),
    );
  }

  Widget _buildSwitchSelection() {
    return const Column(
      children: [
        SwitchSettingItem(title: 'Dark Theme'),
      ],
    );
  }

  Widget _buildAdditionalSection() {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          title: const Text('Terms & Condition'),
        ),
        ListTile(
          onTap: () {},
          title: const Text('Privacy Statement'),
        ),
        const MultipleChoiceSettingItem(title: 'Version', choice: '0.0.1'),
      ],
    );
  }
}
