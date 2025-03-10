import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';

class PreviewHeaderUtils {
  buildHeader(String currentDate) {
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
    );
  }

  buildClientDetails() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("FROM",
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
            pw.Text("BILL TO",
                style: pw.TextStyle(
                    fontSize: AppSizes.s10, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: AppSizes.s10),
            pw.Text("Demo Client",
                style: pw.TextStyle(
                    fontSize: AppSizes.s15, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: AppSizes.s3),
            pw.Text("9876433861",
                style: const pw.TextStyle(fontSize: AppSizes.s13)),
            pw.SizedBox(height: AppSizes.s3),
            pw.Text("abc@xyz.com",
                style: const pw.TextStyle(fontSize: AppSizes.s13)),
            pw.SizedBox(height: AppSizes.s3),
            pw.Text("XYZ", style: const pw.TextStyle(fontSize: AppSizes.s13)),
            pw.SizedBox(height: AppSizes.s3),
          ],
        ),
      ],
    );
  }
}
