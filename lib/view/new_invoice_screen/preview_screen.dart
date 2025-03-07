import 'package:flutter/material.dart';
import 'package:invoice_maker/core/utils/preview_utils.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../widgets/custom_app_bar.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarType: AppBarType.preview,
        onPreviewDone: () => Navigator.pop(context),
      ),
      body: PdfPreview(
        canChangePageFormat: false,
        canChangeOrientation: false,
        build: (format) => PreviewUtils().generatePdf(),
        initialPageFormat: PdfPageFormat.a4,
        pdfFileName: "invoice.pdf",
        allowPrinting: false,
        allowSharing: false,
      ),
    );
  }
}
