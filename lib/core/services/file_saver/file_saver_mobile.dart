import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> saveAndOpenDocumentImpl({
  required Uint8List bytes,
  required String fileName,
}) async {
  try {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(bytes);
    
    await Share.shareXFiles(
      [XFile(file.path, mimeType: 'application/pdf')],
      subject: fileName,
    );
  } catch (e) {
    rethrow;
  }
}
