import 'package:flutter/material.dart';

import '../enums/activity_type.dart';

T stringToEnum<T>(String key, List<T> values) {
  return values.firstWhere((e) => e.toString().split('.').last == key,
      orElse: () => throw ArgumentError('No enum value with that key'));
}

String enumToString<T>(T value) {
  return T.toString().split('.').last;
}

IconData getActivityIcon(ActivityType type) => switch (type) {
      ActivityType.dining => Icons.restaurant,
      ActivityType.breakfast => Icons.free_breakfast,
      ActivityType.lunch => Icons.lunch_dining,
      ActivityType.sightseeing => Icons.camera_alt,
      ActivityType.rest => Icons.bed,
      ActivityType.exploring => Icons.map,
      ActivityType.transportation => Icons.directions_bus,
    };
