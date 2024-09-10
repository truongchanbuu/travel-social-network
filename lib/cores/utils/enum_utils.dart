T stringToEnum<T>(String key, List<T> values) {
  return values.firstWhere((e) => e.toString().split('.').last == key,
      orElse: () => throw ArgumentError('No enum value with that key'));
}
