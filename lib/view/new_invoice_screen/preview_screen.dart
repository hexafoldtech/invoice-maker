import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../widgets/custom_app_bar.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  Future<Uint8List> _generatePdf() async {
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
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    AppStrings.blurayPreviewText,
                    style: pw.TextStyle(
                      fontSize: AppSizes.s16.r,
                      color: PdfColor.fromHex("#690623"),
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.only(top: AppSizes.s30.r),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text(AppStrings.invoiceCapsPreviewText,
                            style: pw.TextStyle(
                                fontSize: AppSizes.s20.r,
                                color: PdfColor.fromHex("#690623"),
                                fontWeight: pw.FontWeight.bold)),
                        pw.Text('#003'),
                        pw.Text("${AppStrings.dueDateText} $currentDate"),
                        pw.Text("${AppStrings.issuedDateText} $currentDate"),
                      ],
                    ),
                  ),
                ],
              ),
              // pw.SizedBox(height: 20),
              pw.SizedBox(height: 40),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("FROM",
                          style: pw.TextStyle(
                              fontSize: AppSizes.s10,
                              fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: AppSizes.s10),
                      pw.Text(AppStrings.blurayPreviewText,
                          style: pw.TextStyle(
                              fontSize: AppSizes.s15,
                              fontWeight: pw.FontWeight.bold))
                    ],
                  ),
                  pw.SizedBox(width: AppSizes.s150),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("BILL TO",
                          style: pw.TextStyle(
                              fontSize: AppSizes.s10,
                              fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: AppSizes.s10),
                      pw.Text("Demo Client",
                          style: pw.TextStyle(
                              fontSize: AppSizes.s15,
                              fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: AppSizes.s3),
                      pw.Text("9876433861",
                          style: const pw.TextStyle(fontSize: AppSizes.s13)),
                      pw.SizedBox(height: AppSizes.s3),
                      pw.Text("abc@xyz.com",
                          style: const pw.TextStyle(fontSize: AppSizes.s13)),
                      pw.SizedBox(height: AppSizes.s3),
                      pw.Text("XYZ",
                          style: const pw.TextStyle(fontSize: AppSizes.s13)),
                      pw.SizedBox(height: AppSizes.s3),
                    ],
                  ),
                ],
              ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appBarType: AppBarType.preview),
      body: PdfPreview(
        canChangePageFormat: false,
        canChangeOrientation: false,
        build: (format) => _generatePdf(),
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: "invoice.pdf",
        allowPrinting: false,
        allowSharing: false,
      ),
    );
  }
}
