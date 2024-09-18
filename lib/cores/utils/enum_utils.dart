import 'package:flutter/material.dart';

import '../enums/activity_type.dart';

T stringToEnum<T>(String key, List<T> values) {
  return values.firstWhere((e) => e.toString().split('.').last == key,
      orElse: () => throw ArgumentError('No enum value with that key'));
}

String enumToString<T>(T value) {
  return T.toString().split('.').last;
}

IconData getActivityIcon(ActivityType type) {
  switch (type) {
    case ActivityType.dining:
      return Icons.restaurant;
    case ActivityType.breakfast:
      return Icons.free_breakfast;
    case ActivityType.lunch:
      return Icons.lunch_dining;
    case ActivityType.sightseeing:
      return Icons.camera_alt;
    case ActivityType.rest:
      return Icons.bed;
    case ActivityType.exploring:
      return Icons.map;
    case ActivityType.transportation:
      return Icons.directions_bus;
    default:
      return Icons.help_outline;
  }
}
