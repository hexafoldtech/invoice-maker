import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';

class PreviewHeaderUtils {
  buildHeader(String invNo, String currentDate, String title,
      {String? dueDate}) {
    return pw.Row(
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
              pw.Text(title,
                  style: pw.TextStyle(
                      fontSize: AppSizes.s20.r,
                      color: PdfColor.fromHex("#690623"),
                      fontWeight: pw.FontWeight.bold)),
              pw.Text(invNo),
              if (dueDate != null)
                pw.Text("${AppStrings.dueDateText} $dueDate"),
              pw.Text("${AppStrings.issuedDateText} $currentDate"),
            ],
          ),
        ),
      ],
    );
  }

  buildClientDetails(String clientName, String clientPh, String clientMail,
      String clientAddress) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(AppStrings.fromPreviewText,
                style: pw.TextStyle(
                    fontSize: AppSizes.s10, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: AppSizes.s10),
            pw.Text(AppStrings.blurayPreviewText,
                style: pw.TextStyle(
                    fontSize: AppSizes.s15, fontWeight: pw.FontWeight.bold))
          ],
        ),
        pw.SizedBox(width: AppSizes.s150),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(AppStrings.billToPreviewText,
                style: pw.TextStyle(
                    fontSize: AppSizes.s10, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: AppSizes.s10),
            pw.Text(clientName,
                style: pw.TextStyle(
                    fontSize: AppSizes.s15, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: AppSizes.s3),
            pw.Text(clientPh,
                style: const pw.TextStyle(fontSize: AppSizes.s13)),
            pw.SizedBox(height: AppSizes.s3),
            pw.Text(clientMail,
                style: const pw.TextStyle(fontSize: AppSizes.s13)),
            pw.SizedBox(height: AppSizes.s3),
            pw.Text(clientAddress,
                style: const pw.TextStyle(fontSize: AppSizes.s13)),
            pw.SizedBox(height: AppSizes.s3),
          ],
        ),
      ],
    );
  }
}
