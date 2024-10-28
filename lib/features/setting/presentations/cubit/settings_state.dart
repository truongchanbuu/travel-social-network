part of 'settings_cubit.dart';

enum LanguageCode { en, vi }

enum TemperatureUnit { celsius, fahrenheit }

enum MeasurementSystem { metric, imperial }

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
  SettingsInitial({
    super.isDarkMode = false,
    required super.measurementSystem,
    required super.currency,
    required super.temperatureScale,
  }) : super(
          region: Platform.localeName.split('_').last,
          language: LanguageCode.en.name,
        );
}
