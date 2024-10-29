import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_social_network/features/setting/presentations/cubit/settings_cubit.dart';

import '../../../../cores/utils/currency_helper.dart';
import '../../../../cores/utils/locale_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../widgets/multiple_choice_setting_item.dart';
import '../widgets/switch_setting_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:
            defaultWhiteAppBar(context: context, titleText: S.current.settings),
        body: ListView(
          children: [
            _buildMultipleChoiceSection(context),
            const Divider(),
            _buildSwitchSelection(context),
            const Divider(),
            _buildAdditionalSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildMultipleChoiceSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          MultipleChoiceSettingItem<String>(
            title: S.current.language,
            choice: getLanguageName(context),
            selections: LocaleHelper.supportedLanguages,
            onSelected: (choice) =>
                context.read<SettingsCubit>().languageChanged(choice),
            selected: getLanguageName(context),
          ),
          MultipleChoiceSettingItem<String>(
            title: S.current.currency,
            choice: '',
            selections: CurrencyHelper.supportedCurrencies,
            onSelected: (choice) => print(choice),
            selected: '',
          ),

          // MultipleChoiceSettingItem(
          //   title: S.current.countryRegion,
          //   choice: S.current.countryEnglandRegionChoice,
          // ),

          // MultipleChoiceSettingItem(
          //   title: S.current.units,
          //   choice: S.current.unitsChoice,
          // ),
          // MultipleChoiceSettingItem(
          //   title: S.current.temperatureScale,
          //   choice: 'Celsius',
          // ),
        ],
      ),
    );
  }

  Widget _buildSwitchSelection(BuildContext context) {
    bool isDarkMode = getCurrentThemeMode(context);

    return Column(
      children: [
        SwitchSettingItem(
          title: isDarkMode ? S.current.lightTheme : S.current.darkTheme,
          value: isDarkMode,
          onChanged: (value) {
            context.read<SettingsCubit>().themeChanged(value);
          },
        ),
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
        // MultipleChoiceSettingItem(
        //   title: S.current.version,
        //   choice: currentVersion,
        // ),
      ],
    );
  }

  String getLanguageName(BuildContext context) {
    return context.select((SettingsCubit settingCubit) =>
        LocaleHelper.langCodeToFullName(settingCubit.state.language));
  }

  bool getCurrentThemeMode(BuildContext context) =>
      context.select((SettingsCubit settingCubit) => settingCubit.isDarkMode);
}
