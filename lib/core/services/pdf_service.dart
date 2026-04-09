import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'file_saver/file_saver.dart';

class FirstAidPdfService {
  /// Generates a PDF centered around a single high-quality image (screenshot)
  /// and saves/downloads it. This method avoids all Bengali font issues.
  static Future<bool> generateAndSavePdfFromImage(Uint8List imageBytes, String title) async {
    try {
      final pdf = pw.Document();
      final image = pw.MemoryImage(imageBytes);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(image, fit: pw.BoxFit.contain),
            );
          },
        ),
      );

      final bytes = await pdf.save();
      
      // Sanitize filename for Windows/Web
      final sanitizedTitle = title.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
      final fileName = '${sanitizedTitle}_Guide.pdf';
      
      // On Web, use file downloader; on Mobile, use Share/File access
      await FileSaverService.saveAndOpenDocument(
        bytes: bytes,
        fileName: fileName,
      );
      
      return true;
    } catch (e) {
      return false;
    }
  }
}
