import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import '../../models/EstimateModel/estimate_model.dart';
import '../../providers/client_provider.dart';
import '../../providers/estimate_provider.dart';
import '../../providers/item_provider.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';
import '../constants/global_key.dart';
import 'extensions/date_formatter.dart';
import 'preview_header.dart';

class EstimatePreviewUtils {
  Future<Uint8List> generatePdf({EstimateModel? estimate}) async {
    final pdf = pw.Document();

    final String currentDate = estimate?.issueDate.toFormattedString() ??
        DateFormat('dd/MM/yyyy').format(DateTime.now());

    var itemProvider =
        Provider.of<ItemProvider>(navigatorKey.currentContext!, listen: false);
    var selectedItems = estimate?.items ?? itemProvider.selectedItems;

    List<List<dynamic>> tableData = selectedItems
        .map((item) => [
              "${item.itemName}\n${item.itemDetails}${item.isDiscount ? "\nIncl. ${item.itemDiscountRate}% discount" : ""}",
              item.itemQuantity,
              item.totalItemPrice,
              item.itemPrice
            ])
        .toList();

    var client = estimate?.client ??
        Provider.of<ClientProvider>(navigatorKey.currentContext!, listen: false)
            .selectedClient;
    var estimateProvider = Provider.of<EstimateProvider>(
        navigatorKey.currentContext!,
        listen: false);

    var totalAmount = estimate?.total ?? estimateProvider.totalAmount;
    var subtotal = estimate?.subTotal ?? estimateProvider.subTotal;
    var tax = estimate?.tax?.toStringAsFixed(2) ??
        estimateProvider.tax.toStringAsFixed(2);
    String taxText;
    if (estimate != null && estimate.tax != 0) {
      taxText = "(${estimate.tax} ${estimate.taxType})";
    } else {
      taxText = estimateProvider.taxText == AppStrings.taxText
          ? ''
          : estimateProvider.taxText.substring(4);
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              PreviewHeaderUtils().buildHeader(
                  "#${estimateProvider.generateEstimateId()}",
                  currentDate,
                  AppStrings.estimateCapsPreviewText),
              pw.SizedBox(height: 40),
              PreviewHeaderUtils().buildClientDetails(
                  client!.clientName,
                  client.clientPhoneNumber,
                  client.clientEmail,
                  client.clientAddress),
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
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(
                          right:
                              pw.BorderSide(width: 1.5, color: PdfColors.black),
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
                        child: pw.Text(subtotal.toString(),
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
                        child: pw.Text("${AppStrings.taxText} $taxText",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(5),
                        child: pw.Text(tax,
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
                        child: pw.Text(totalAmount.toString(),
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
