import 'package:invoice_maker/core/utils/preview_header.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:intl/intl.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

class PreviewUtils {
  Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();

    final String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    var items = [
      {"description": 'Item A', "quantity": 5, "Price": 300.0, "Amount": 300.0},
      {"description": 'Item B', "quantity": 2, "Price": 450.0, "Amount": 300.0},
      {"description": 'Item C', "quantity": 3, "Price": 450.0, "Amount": 300.0},
    ];

    List<List<dynamic>> tableData = items
        .map((item) => [
              item["description"],
              item["quantity"],
              item["Price"],
              item['Amount']
            ])
        .toList();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              PreviewHeaderUtils().buildHeader(currentDate),
              pw.SizedBox(height: 40),
              PreviewHeaderUtils().buildClientDetails(),
              pw.SizedBox(height: AppSizes.s30),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(0.9),
                  1: const pw.FlexColumnWidth(0.15),
                  2: const pw.FlexColumnWidth(0.3),
                  3: const pw.FlexColumnWidth(0.3),
                },
                children: [
                  /// **Header Row**
                  pw.TableRow(
                    decoration:
                        const pw.BoxDecoration(color: PdfColors.pink100),
                    children: [
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(AppStrings.descriptionPreviewText,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(AppStrings.qtyPreviewText,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(AppStrings.pricePreviewText,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                      pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(AppStrings.amountPreviewText,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold))),
                    ],
                  ),

                  /// **Invoice Items**
                  ...tableData.map((row) {
                    return pw.TableRow(
                      decoration: pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(
                              width: row == tableData[2]
                                  ? 1.5
                                  : 0, // **Add vertical border after 3rd row**
                              color: PdfColors.black),
                        ),
                      ),
                      children: row.map((cell) {
                        return pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(cell.toString()),
                        );
                      }).toList(),
                    );
                  }),

                  /// **Subtotal, Tax, and Total**
                  pw.TableRow(
                    children: [
                      pw.SizedBox(), // Empty Cell
                      pw.SizedBox(), // Empty Cell
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(AppStrings.subTotalText,
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text("2000.0",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.SizedBox(),
                      pw.SizedBox(),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(AppStrings.taxText,
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text("500.0",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.SizedBox(),
                      pw.SizedBox(),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(AppStrings.totalCapitalText,
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: AppSizes.s14)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text("2500.0",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: AppSizes.s14)),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
