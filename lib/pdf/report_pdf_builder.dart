import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../domain/models/calculation.dart';

class ReportPdfBuilder {
  ReportPdfBuilder._();

  static Future<Uint8List> buildPdf({
    required Calculation calculation,
    required String languageCode,
  }) async {
    final pdf = pw.Document();

    // Parse calculation JSON data
    Map<String, dynamic> data = {};
    try {
      data = jsonDecode(calculation.dataJson) as Map<String, dynamic>;
    } catch (_) {}

    final deceasedName = data['deceasedName'] ?? calculation.title;
    final grossAssets = (data['grossAssets'] as num?)?.toDouble() ?? 0.0;
    final debts = (data['debts'] as num?)?.toDouble() ?? 0.0;
    final funeral = (data['funeralExpenses'] as num?)?.toDouble() ?? 0.0;
    final bequest = (data['bequestAmount'] as num?)?.toDouble() ?? 0.0;
    final netEstate = (data['netDistributableEstate'] as num?)?.toDouble() ?? 0.0;
    final sharesList = (data['shares'] as List<dynamic>?) ?? [];

    // Load appropriate font
    pw.Font mainFont;
    try {
      if (languageCode == 'ur') {
        final fontData = await rootBundle.load('assets/fonts/NotoNastaliqUrdu-Regular.ttf');
        mainFont = pw.Font.ttf(fontData);
      } else if (languageCode == 'ar') {
        final fontData = await rootBundle.load('assets/fonts/NotoNaskhArabic-Regular.ttf');
        mainFont = pw.Font.ttf(fontData);
      } else {
        final fontData = await rootBundle.load('assets/fonts/Poppins-Regular.ttf');
        mainFont = pw.Font.ttf(fontData);
      }
    } catch (_) {
      mainFont = pw.Font.helvetica();
    }

    final isRTL = languageCode == 'ur' || languageCode == 'ar';
    final textDirection = isRTL ? pw.TextDirection.rtl : pw.TextDirection.ltr;

    // Theme Colors
    const primaryColor = PdfColor.fromInt(0xFF1A3C2E); // Deep Islamic Green
    const goldColor = PdfColor.fromInt(0xFFD4A843); // Signature Gold
    const lightBg = PdfColor.fromInt(0xFFFDFBF7);
    const borderColor = PdfColor.fromInt(0xFFE0D8CC);
    const textColor = PdfColor.fromInt(0xFF1C1C1E);
    const textMuted = PdfColor.fromInt(0xFF6B6B6B);

    final titleText = switch (languageCode) {
      'ur' => 'سراجی — رپورٹ تقسیمِ وراثت و فرائض',
      'ar' => 'سراجي — تقرير قسمة التركات والمواريث الشرعية',
      _ => 'Siraji — Islamic Inheritance & Faraid Report',
    };

    final deceasedLabel = switch (languageCode) {
      'ur' => 'متوفی کا نام / حوالہ',
      'ar' => 'اسم / صفة المتوفى',
      _ => 'Deceased Name / Reference',
    };

    final dateLabel = switch (languageCode) {
      'ur' => 'تاریخِ حساب',
      'ar' => 'تاريخ الحساب',
      _ => 'Calculation Date',
    };

    final estateSummaryTitle = switch (languageCode) {
      'ur' => 'ترکہ اور کٹوتیوں کا خلاصہ',
      'ar' => 'خلاصة التركة والحقوق المستحقة',
      _ => 'Estate & Deductions Summary',
    };

    final grossLabel = switch (languageCode) {
      'ur' => 'کل مالیتِ ترکہ',
      'ar' => 'إجمالي التركة',
      _ => 'Gross Estate Value',
    };

    final debtsLabel = switch (languageCode) {
      'ur' => 'واجب الادا قرضے (دیون)',
      'ar' => 'الديون المستحقة',
      _ => 'Outstanding Debts (Duyun)',
    };

    final funeralLabel = switch (languageCode) {
      'ur' => 'تجہیز و تکفین کے اخراجات',
      'ar' => 'مؤن التجهيز والدفن',
      _ => 'Funeral & Burial Expenses',
    };

    final bequestLabel = switch (languageCode) {
      'ur' => 'جائز وصیت (زیادہ سے زیادہ 1/3)',
      'ar' => 'الوصية الشرعية (حد أقصى الثلث)',
      _ => 'Bequest / Wasiyyah (Max 1/3)',
    };

    final netLabel = switch (languageCode) {
      'ur' => 'قابلِ تقسیم خالص ترکہ',
      'ar' => 'صافي التركة الموزعة',
      _ => 'Net Distributable Estate',
    };

    final heirsBreakdownTitle = switch (languageCode) {
      'ur' => 'ورثاء کے حصص اور تقسیم کی تفصیل',
      'ar' => 'تفصيل أنصبة وسهام الورثة',
      _ => 'Heirs Shares & Distribution Breakdown',
    };

    final disclaimerText = switch (languageCode) {
      'ur' =>
        'نوٹ: یہ حسابی رپورٹ مستند اسلامی فقہ کے اصولوں پر مبنی تعلیمی رہنمائی کے لیے تیار کی گئی ہے۔ عملی تقسیم سے قبل مستند مفتی یا شرعی دارالافتاء سے تصدیق لازمی حاصل کریں۔',
      'ar' =>
        'تنبيه: هذا التقرير أداة إرشادية وتأصيلية وفقاً لقواعد الفقه الإسلامي. يرجى مراجعة المسائل الواقعية مع جهة إفتاء أو قضاء شرعي معتمد قبل القسمة الفعلية.',
      _ =>
        'Note: This calculation report is prepared for educational and preliminary informational purposes based on standard Islamic jurisprudence. Real-world distribution must be verified with a qualified Islamic authority.',
    };

    final dateStr = '${calculation.createdAt.day}/${calculation.createdAt.month}/${calculation.createdAt.year}';

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        textDirection: textDirection,
        theme: pw.ThemeData.withFont(base: mainFont),
        build: (pw.Context context) {
          return [
            // 1. Report Header Banner
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: const pw.BoxDecoration(
                color: primaryColor,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(8)),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: isRTL ? pw.CrossAxisAlignment.end : pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        titleText,
                        style: pw.TextStyle(
                          font: mainFont,
                          color: goldColor,
                          fontSize: 16,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        '$deceasedLabel: $deceasedName',
                        style: pw.TextStyle(
                          font: mainFont,
                          color: PdfColors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: isRTL ? pw.CrossAxisAlignment.start : pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'SIRAJI',
                        style: pw.TextStyle(
                          font: mainFont,
                          color: goldColor,
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text(
                        '$dateLabel: $dateStr',
                        style: pw.TextStyle(
                          font: mainFont,
                          color: PdfColors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // 2. Estate Summary Section
            pw.Text(
              estateSummaryTitle,
              style: pw.TextStyle(
                font: mainFont,
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
                color: primaryColor,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: lightBg,
                border: pw.Border.all(color: borderColor),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
              ),
              child: pw.Column(
                children: [
                  _pdfSummaryRow(grossLabel, grossAssets.toStringAsFixed(0), mainFont, textColor),
                  if (debts > 0)
                    _pdfSummaryRow(debtsLabel, '- ${debts.toStringAsFixed(0)}', mainFont, PdfColors.red900),
                  if (funeral > 0)
                    _pdfSummaryRow(funeralLabel, '- ${funeral.toStringAsFixed(0)}', mainFont, PdfColors.red900),
                  if (bequest > 0)
                    _pdfSummaryRow(bequestLabel, '- ${bequest.toStringAsFixed(0)}', mainFont, PdfColors.red900),
                  pw.Divider(color: borderColor, height: 12),
                  _pdfSummaryRow(
                    netLabel,
                    netEstate.toStringAsFixed(0),
                    mainFont,
                    primaryColor,
                    isBold: true,
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),

            // 3. Heirs Breakdown Table
            pw.Text(
              heirsBreakdownTitle,
              style: pw.TextStyle(
                font: mainFont,
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
                color: primaryColor,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Table(
              border: pw.TableBorder.all(color: borderColor, width: 0.5),
              children: [
                // Table Header
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: primaryColor),
                  children: [
                    _pdfTableCell(isRTL ? 'الوارث / وارث' : 'Heir', mainFont, goldColor, isHeader: true),
                    _pdfTableCell(isRTL ? 'العدد' : 'Count', mainFont, goldColor, isHeader: true),
                    _pdfTableCell(isRTL ? 'الفرض / حصہ' : 'Share', mainFont, goldColor, isHeader: true),
                    _pdfTableCell(isRTL ? 'الإجمالي' : 'Total Amount', mainFont, goldColor, isHeader: true),
                    _pdfTableCell(isRTL ? 'الفرد' : 'Per Person', mainFont, goldColor, isHeader: true),
                  ],
                ),
                // Table Rows
                ...sharesList.map((item) {
                  final map = item as Map<String, dynamic>;
                  final heirId = (map['heirId'] as String?)?.toUpperCase() ?? '';
                  final count = map['count']?.toString() ?? '1';
                  final fraction = map['fraction']?.toString() ?? '';
                  final percentage = map['percentage']?.toString() ?? '';
                  final shareStr = '$fraction ($percentage)';
                  final amount = (map['amount'] as num?)?.toDouble() ?? 0.0;
                  final countNum = int.tryParse(count) ?? 1;
                  final indivAmount = countNum > 0 ? amount / countNum : amount;

                  return pw.TableRow(
                    decoration: const pw.BoxDecoration(color: lightBg),
                    children: [
                      _pdfTableCell(heirId, mainFont, textColor),
                      _pdfTableCell(count, mainFont, textColor),
                      _pdfTableCell(shareStr, mainFont, textColor),
                      _pdfTableCell(amount.toStringAsFixed(0), mainFont, primaryColor, isBold: true),
                      _pdfTableCell(indivAmount.toStringAsFixed(0), mainFont, textMuted),
                    ],
                  );
                }),
              ],
            ),
            pw.SizedBox(height: 24),

            // 4. Disclaimer Box
            pw.Container(
              padding: const pw.EdgeInsets.all(12),
              decoration: pw.BoxDecoration(
                color: lightBg,
                border: pw.Border.all(color: goldColor),
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
              ),
              child: pw.Text(
                disclaimerText,
                style: pw.TextStyle(
                  font: mainFont,
                  fontSize: 9,
                  color: textMuted,
                  lineSpacing: 1.4,
                ),
              ),
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _pdfSummaryRow(
    String label,
    String value,
    pw.Font font,
    PdfColor color, {
    bool isBold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            label,
            style: pw.TextStyle(
              font: font,
              fontSize: 10,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
          pw.Text(
            value,
            style: pw.TextStyle(
              font: font,
              fontSize: 10,
              color: color,
              fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _pdfTableCell(
    String text,
    pw.Font font,
    PdfColor color, {
    bool isHeader = false,
    bool isBold = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          font: font,
          fontSize: isHeader ? 10 : 9,
          color: color,
          fontWeight: (isHeader || isBold) ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }

  /// Print or Preview PDF using printing package
  static Future<void> printReport({
    required Calculation calculation,
    required String languageCode,
  }) async {
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => buildPdf(
        calculation: calculation,
        languageCode: languageCode,
      ),
      name: 'Siraji_Report_${calculation.id}.pdf',
    );
  }

  /// Share PDF using platform native share intent
  static Future<void> shareReport({
    required Calculation calculation,
    required String languageCode,
  }) async {
    final pdfBytes = await buildPdf(
      calculation: calculation,
      languageCode: languageCode,
    );

    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: 'Siraji_Inheritance_Report_${calculation.id}.pdf',
    );
  }
}
