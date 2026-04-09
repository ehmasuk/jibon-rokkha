import 'dart:typed_data';
import 'file_saver_unsupported.dart'
    if (dart.library.html) 'file_saver_web.dart'
    if (dart.library.io) 'file_saver_mobile.dart';

class FileSaverService {
  static Future<void> saveAndOpenDocument({
    required Uint8List bytes,
    required String fileName,
  }) async {
    await saveAndOpenDocumentImpl(bytes: bytes, fileName: fileName);
  }
}
