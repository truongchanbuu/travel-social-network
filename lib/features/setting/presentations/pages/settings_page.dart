import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/utils/currency_helper.dart';
import '../../../../cores/utils/extensions/context_extension.dart';
import '../../../../cores/utils/locale_helper.dart';
import '../../../../generated/l10n.dart';
import '../../../shared/presentations/widgets/default_white_appbar.dart';
import '../cubit/settings_cubit.dart';
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
            choice: LocaleHelper.langCodeToFullName(context.langCode),
            selections: LocaleHelper.supportedLanguages,
            onSelected: context.read<SettingsCubit>().languageChanged,
            selected: LocaleHelper.langCodeToFullName(context.langCode),
          ),
          MultipleChoiceSettingItem<String>(
            title: S.current.currency,
            choice: context
                .select((SettingsCubit settings) => settings.state.currency),
            selections: CurrencyHelper.supportedCurrencies,
            onSelected: context.read<SettingsCubit>().currencyChanged,
            selected: CurrencyHelper.currentCurrencyUnit,
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
    return Column(
      children: [
        SwitchSettingItem(
          title:
              !context.isDarkMode ? S.current.lightTheme : S.current.darkTheme,
          value: context.isDarkMode,
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
}
