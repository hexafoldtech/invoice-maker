import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'preview_header.dart';
import 'extensions/date_formatter.dart';
import '../../models/InvoiceModel/invoice_model.dart';
import '../../providers/invoice_provider.dart';
import '../../providers/client_provider.dart';
import '../../providers/item_provider.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../constants/global_key.dart';

class InvoicePreviewUtils {
  Future<Uint8List> generatePdf({InvoiceModel? invoice}) async {
    final pdf = pw.Document();

    final String currentDate = invoice?.issueDate.toFormattedString() ??
        DateFormat('dd/MM/yyyy').format(DateTime.now());

    var itemProvider =
        Provider.of<ItemProvider>(navigatorKey.currentContext!, listen: false);
    var selectedItems = invoice?.items ?? itemProvider.selectedItems;
    List<List<dynamic>> tableData = selectedItems
        .map((item) => [
              "${item.itemName}\n${item.itemDetails}${item.isDiscount ? "\nIncl. ${item.itemDiscountRate}% discount" : ""}",
              item.itemQuantity,
              item.totalItemPrice,
              item.itemPrice
            ])
        .toList();

    var client = invoice?.client ??
        Provider.of<ClientProvider>(navigatorKey.currentContext!, listen: false)
            .selectedClient;
    var invoiceProvider = Provider.of<InvoiceProvider>(
        navigatorKey.currentContext!,
        listen: false);

    var dueDate = DateFormat('dd/MM/yyyy').format(
      invoice?.dueDate ??
          DateFormat('dd MMM yyyy').parse(invoiceProvider.dueDate),
    );
    var totalAmount = invoice?.total ?? invoiceProvider.totalAmount;
    var subtotal = invoice?.subTotal ?? invoiceProvider.subTotal;
    var tax = invoice?.tax?.toStringAsFixed(2) ??
        invoiceProvider.tax.toStringAsFixed(2);
    String taxText;
    if (invoice != null && invoice.tax != 0) {
      taxText = "(${invoice.tax} ${invoice.taxType})";
    } else {
      taxText = invoiceProvider.taxText == AppStrings.taxText
          ? ''
          : invoiceProvider.taxText.substring(4);
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
                  "#${invoiceProvider.generateInvoiceId()}",
                  AppStrings.invoiceCapsPreviewText,
                  currentDate,
                  dueDate: dueDate),
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
