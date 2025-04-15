import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/estimate_preview_utils.dart';
import '../../models/EstimateModel/estimate_model.dart';
import '../widgets/custom_app_bar.dart';

enum PreviewType { preview, details }

class EstimatePreviewScreen extends StatelessWidget {
  final PreviewType type;
  final EstimateModel? estimate;
  const EstimatePreviewScreen({super.key, required this.type, this.estimate});

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
          build: (format) =>
              EstimatePreviewUtils().generatePdf(estimate: estimate),
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
          build: (format) => EstimatePreviewUtils().generatePdf(),
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
