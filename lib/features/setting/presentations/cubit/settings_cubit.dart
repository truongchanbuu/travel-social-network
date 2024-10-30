import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/storage_keys.dart';
import '../../../../cores/utils/cached_client.dart';
import '../../../../cores/utils/currency_helper.dart';
import '../../../../cores/utils/locale_helper.dart';
import '../../../../cores/utils/setting_helper.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final CacheClient cacheClient;
  SettingsCubit(this.cacheClient) : super(SettingsInitial());

  Locale get currentLocale => Locale.fromSubtags(languageCode: state.language);
  bool get isDarkMode => state.isDarkMode;

  Future<void> languageChanged(String value) async {
    await cacheClient.setString(StorageKeys.appLanguageCachedKey,
        LocaleHelper.langFullNameToCode(value));
    emit(LanguageChanged(state, LocaleHelper.langFullNameToCode(value)));
  }

  Future<void> themeChanged(bool value) async {
    await cacheClient.setBool(StorageKeys.appThemeCachedKey, value);
    emit(ThemeModeChanged(state, value));
  }

  Future<void> currencyChanged(String value) async {
    await cacheClient.setString(StorageKeys.appCurrencyCachedKey, value);
    emit(CurrencyChanged(state, value));
  }

  Future<void> measurementSystemChanged(String value) async {
    await cacheClient.setString(
        StorageKeys.appMeasurementSystemCachedKey, value);
    emit(MeasurementSystemChanged(state, value));
  }

  Future<void> temperatureScaleChanged(String value) async {
    await cacheClient.setString(
        StorageKeys.appTemperatureScaleCachedKey, value);
    emit(TemperatureScaleChanged(state, value));
  }
}
