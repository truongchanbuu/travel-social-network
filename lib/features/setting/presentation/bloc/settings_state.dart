part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  final String locale;
  final String currency;
  final String language;
  final String measurement;
  final String temperatureUnit;

  const SettingsState({
    required this.locale,
    required this.currency,
    required this.language,
    required this.measurement,
    required this.temperatureUnit,
  });

  @override
  List<Object> get props => [
        locale,
        currency,
        language,
        measurement,
        temperatureUnit,
      ];
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial({
    required super.locale,
    required super.currency,
    required super.language,
    required super.measurement,
    required super.temperatureUnit,
  });
}
