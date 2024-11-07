import 'dart:convert';

import 'package:flutter/foundation.dart';

class QuillContentFormatter {
  static const String insertKey = 'insert';
  static const String needleCharacter = '\n';

  static String checkAndConvertQuillFormat(String input) {
    try {
      final decoded = json.decode(input);
      if (decoded is List &&
          decoded.isNotEmpty &&
          decoded.every(_isValidQuillBlock)) {
        if ((decoded.last)[insertKey] != needleCharacter) {
          decoded.add({insertKey: needleCharacter});
          input = json.encode(decoded);
        }

        return input;
      }
    } catch (e) {
      debugPrint(
          'Quill Content Error: $e - This error is only for announcement');
    }

    return json.encode([
      {insertKey: '$input$needleCharacter'}
    ]);
  }

  static bool _isValidQuillBlock(dynamic block) {
    return block is Map<String, dynamic> &&
        block.containsKey(insertKey) &&
        block[insertKey] is String;
  }

  static String convertToPlainText(String input) {
    try {
      final decoded = json.decode(input);

      if (decoded is List && decoded.isNotEmpty) {
        String plainText = '';

        for (var block in decoded) {
          if (_isValidQuillBlock(block)) {
            String blockText = block[insertKey] as String;
            plainText += blockText;
          }
        }

        if (plainText.endsWith(needleCharacter)) {
          plainText = plainText.substring(0, plainText.length - 1);
        }

        return plainText;
      }
    } catch (e) {
      debugPrint('Error during Quill formatting to plain text: $e');
    }

    return '';
  }
}
