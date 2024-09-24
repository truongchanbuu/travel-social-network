import 'package:flutter/material.dart';

import '../../../../cores/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../widgets/multiple_choice_setting_item.dart';
import '../widgets/switch_setting_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(S.current.settings),
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
      child: Column(
        children: [
          MultipleChoiceSettingItem(
            title: S.current.language,
            choice: S.current.englishLangChoice,
          ),
          MultipleChoiceSettingItem(
            title: S.current.countryRegion,
            choice: S.current.countryEnglandRegionChoice,
          ),
          MultipleChoiceSettingItem(
            title: S.current.currency,
            choice: S.current.currencyChoice,
          ),
          MultipleChoiceSettingItem(
            title: S.current.units,
            choice: S.current.unitsChoice,
          ),
          MultipleChoiceSettingItem(
            title: S.current.temperatureScale,
            choice: S.current.C,
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchSelection() {
    return Column(
      children: [
        SwitchSettingItem(title: S.current.darkTheme),
      ],
    );
  }

  Widget _buildAdditionalSection() {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          title: Text(S.current.termAndCondition),
        ),
        ListTile(
          onTap: () {},
          title: Text(S.current.privacyStatement),
        ),
        MultipleChoiceSettingItem(
          title: S.current.version,
          choice: currentVersion,
        ),
      ],
    );
  }
}
