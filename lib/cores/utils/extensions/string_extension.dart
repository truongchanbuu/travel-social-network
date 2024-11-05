extension StringExtension on String {
  String get obscure {
    if (length <= 4) {
      if (length == 4) {
        return '${substring(0, 1)}**${substring(3)}';
      } else if (length == 3) {
        return '${this[0]}*${this[2]}';
      } else if (length == 2) {
        return '*' * 2;
      } else {
        return this;
      }
    }

    int startLength = 1;
    int endLength = 3;

    String start = substring(0, startLength);
    String end = substring(length - endLength);

    String obscured = start + '*' * (length - startLength - endLength) + end;

    return obscured;
  }

  String get toUpperCaseFirstLetter {
    if (isEmpty) {
      return this;
    }

    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
