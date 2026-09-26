import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CertificateService {
  static Future<void> generateAndDownload({
    required String studentName,
    required String category,
    required int score,
    required String verificationId,
    required String issueDate,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(16),
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(24),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColor.fromHex('#D4AF37'), width: 5), // Gold border
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                // Top Header Row
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('CEP', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#0F2942'))),
                        pw.Text('Community Engagement Project', style: pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
                      ],
                    ),
                    pw.Text('LEARN | AWARE | STAY SAFE', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#0F2942'))),
                  ],
                ),
                pw.SizedBox(height: 14),

                // Title
                pw.Text('Certificate of', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#0F2942'))),
                pw.Text('Digital Safety & Cyber Vigilance', style: pw.TextStyle(fontSize: 26, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#C59B27'))),
                pw.SizedBox(height: 12),

                pw.Text('This is to certify that', style: const pw.TextStyle(fontSize: 12)),
                pw.SizedBox(height: 6),

                // Name
                pw.Text(
                  studentName.toUpperCase(),
                  style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#0F2942')),
                ),
                pw.SizedBox(height: 8),

                pw.Text(
                  'Has successfully completed the Community Cyber Security Awareness & Scam Detection Training.',
                  textAlign: pw.TextAlign.center,
                  style: const pw.TextStyle(fontSize: 12),
                ),
                pw.SizedBox(height: 18),

                // Score Badge Card
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#0F2942'),
                    borderRadius: pw.BorderRadius.circular(6),
                  ),
                  child: pw.Row(
                    mainAxisSize: pw.MainAxisSize.min,
                    children: [
                      pw.Text('Score: $score%   |   Category: $category', style: pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                ),

                pw.Spacer(),

                // Bottom Footer Info
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Issue Date: $issueDate', style: const pw.TextStyle(fontSize: 10)),
                        pw.Text('Verification ID: $verificationId', style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                    pw.Column(
                      children: [
                        pw.Container(width: 120, height: 1, color: PdfColors.grey700),
                        pw.SizedBox(height: 4),
                        pw.Text('CEP Program Coordinator', style: const pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 6),
                pw.Text(
                  'Organized under Community Engagement Project (CEP) - Safe Digital Practices Drive.',
                  style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'CEP_Certificate_${studentName.replaceAll(' ', '_')}.pdf',
    );
  }
}
