import 'dart:convert';
import 'package:flutter/foundation.dart';

class QuillContentFormatter {
  static String checkAndConvertQuillFormat(String input) {
    try {
      final decoded = json.decode(input);
      if (decoded is List &&
          decoded.isNotEmpty &&
          decoded.every(_isValidQuillBlock)) {
        return input;
      }
    } catch (e) {
      debugPrint(
          'Quill Content Error: $e - This error is only for announcement');
    }

    return json.encode([
      {"insert": '$input\n'}
    ]);
  }

  static bool _isValidQuillBlock(dynamic block) {
    return block is Map<String, dynamic> &&
        block.containsKey('insert') &&
        block['insert'] is String;
  }
}
