part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  final bool isDarkMode;
  final String language;
  final String region;
  final String measurementSystem;
  final String currency;
  final String temperatureScale;

  const SettingsState({
    required this.isDarkMode,
    required this.language,
    required this.region,
    required this.measurementSystem,
    required this.currency,
    required this.temperatureScale,
  });

  @override
  List<Object> get props => [
        isDarkMode,
        language,
        measurementSystem,
        currency,
        temperatureScale,
      ];
}

final class SettingsInitial extends SettingsState {
  SettingsInitial()
      : super(
          isDarkMode: SettingHelper.isDarkMode,
          region: LocaleHelper.getRegion,
          language: LocaleHelper.getDefaultLanguage(),
          currency: CurrencyHelper.currentCurrencyUnit,
          measurementSystem: LocaleHelper.getDefaultMeasurementSystem(),
          temperatureScale: LocaleHelper.getDefaultTemperature(),
        );
}

final class LanguageChanged extends SettingsState {
  LanguageChanged(SettingsState current, String language)
      : super(
          language: language,
          isDarkMode: current.isDarkMode,
          currency: current.currency,
          temperatureScale: current.temperatureScale,
          measurementSystem: current.measurementSystem,
          region: current.region,
        );
}

final class ThemeModeChanged extends SettingsState {
  ThemeModeChanged(SettingsState current, bool isDarkMode)
      : super(
          language: current.language,
          isDarkMode: isDarkMode,
          currency: current.currency,
          temperatureScale: current.temperatureScale,
          measurementSystem: current.measurementSystem,
          region: current.region,
        );
}

final class CurrencyChanged extends SettingsState {
  CurrencyChanged(SettingsState current, String currency)
      : super(
          language: current.language,
          isDarkMode: current.isDarkMode,
          currency: currency,
          temperatureScale: current.temperatureScale,
          measurementSystem: current.measurementSystem,
          region: current.region,
        );
}

final class MeasurementSystemChanged extends SettingsState {
  MeasurementSystemChanged(SettingsState current, String measurementSystem)
      : super(
          language: current.language,
          isDarkMode: current.isDarkMode,
          currency: current.currency,
          temperatureScale: current.temperatureScale,
          measurementSystem: measurementSystem,
          region: current.region,
        );
}

final class TemperatureScaleChanged extends SettingsState {
  TemperatureScaleChanged(SettingsState current, String temperatureScale)
      : super(
          language: current.language,
          isDarkMode: current.isDarkMode,
          currency: current.currency,
          temperatureScale: temperatureScale,
          measurementSystem: current.measurementSystem,
          region: current.region,
        );
}
