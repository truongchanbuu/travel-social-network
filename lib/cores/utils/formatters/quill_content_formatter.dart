import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuillContentFormatter {
  static String checkAndConvertQuillFormat(String input) {
    try {
      final decoded = jsonDecode(input);

      if (decoded is List) {
        if (decoded
            .every((block) => block is Map && block.containsKey('insert'))) {
          return input;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    final convertedContent = [
      {"insert": '$input\n'}
    ];

    return json.encode(convertedContent);
  }
}
