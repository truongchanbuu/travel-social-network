import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

Future<File?> createTmpFile(Uint8List data, String? mimeType) async {
  if (mimeType != null) {
    try {
      final tempDir = await getTemporaryDirectory();
      final extension = extensionFromMime(mimeType);
      final tempFile = File('${tempDir.path}/${const Uuid().v4()}$extension');
      await tempFile.writeAsBytes(data);
      return tempFile;
    } catch (e) {
      log(e.toString());
    }
  }

  return null;
}
