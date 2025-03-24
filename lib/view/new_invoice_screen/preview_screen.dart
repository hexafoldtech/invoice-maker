import 'package:flutter/material.dart';
import 'package:invoice_maker/core/constants/app_colors.dart';
import 'package:invoice_maker/core/utils/preview_utils.dart';
import 'package:invoice_maker/models/InvoiceModel/invoice_model.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../widgets/custom_app_bar.dart';

enum PreviewType { preview, details }

class PreviewScreen extends StatelessWidget {
  final PreviewType type;
  final InvoiceModel? invoice;
  const PreviewScreen({super.key, required this.type, this.invoice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appBarType: AppBarType.preview,
          onPreviewDone: () => Navigator.pop(context),
        ),
        body: _buildBody());
  }

  _buildBody() {
    switch (type) {
      case PreviewType.details:
        return PdfPreview(
          canChangePageFormat: false,
          canChangeOrientation: false,
          build: (format) => PreviewUtils().generatePdf(invoice: invoice),
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "invoice.pdf",
          allowPrinting: false,
          allowSharing: true,
          canDebug: false,
          actionBarTheme:
              const PdfActionBarTheme(backgroundColor: AppColors.darkBlueShade),
        );
      case PreviewType.preview:
        return PdfPreview(
          canChangePageFormat: false,
          canChangeOrientation: false,
          build: (format) => PreviewUtils().generatePdf(),
          initialPageFormat: PdfPageFormat.a4,
          pdfFileName: "invoice.pdf",
          allowPrinting: false,
          allowSharing: true,
          canDebug: false,
          actionBarTheme:
              const PdfActionBarTheme(backgroundColor: AppColors.darkBlueShade),
        );
    }
  }
}
