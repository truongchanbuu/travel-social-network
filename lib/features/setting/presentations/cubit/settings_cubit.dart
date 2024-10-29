import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cores/constants/storage_key.dart';
import '../../../../cores/utils/cached_client.dart';
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
}
