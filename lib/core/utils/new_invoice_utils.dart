import 'package:flutter/material.dart';
import 'package:invoice_maker/view/new_invoice_screen/preview_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/client_provider.dart';
import '../../providers/invoice_provider.dart';
import '../../providers/item_provider.dart';
import '../definitions/route_names.dart';
import 'dialog_boxes.dart';

class NewInvoiceUtils {
  void onCancel(BuildContext context) {
    Navigator.pop(context);
    if (Provider.of<ClientProvider>(context, listen: false).selectedClient !=
            null ||
        Provider.of<ItemProvider>(context, listen: false)
            .selectedItems
            .isNotEmpty) {
      Provider.of<ClientProvider>(context, listen: false).clearSelectedClient();
      Provider.of<ItemProvider>(context, listen: false).clearSelectedItems();
    }
  }

  void onPreview(BuildContext context) {
    if (Provider.of<ClientProvider>(context, listen: false).selectedClient !=
            null &&
        Provider.of<ItemProvider>(context, listen: false)
            .selectedItems
            .isNotEmpty) {
      Navigator.pushNamed(context, RouteNames.previewScreen,
          arguments: {'type': PreviewType.preview});
    } else {
      DialogBoxes().showPreviewDialog(context);
    }
  }

  void onSaveInvoice(BuildContext context) {
    if (Provider.of<ClientProvider>(context, listen: false).selectedClient !=
            null &&
        Provider.of<ItemProvider>(context, listen: false)
            .selectedItems
            .isNotEmpty) {
      var invoiceProvider =
          Provider.of<InvoiceProvider>(context, listen: false);
      var newInvoice = invoiceProvider.createInvoiceModel();
      invoiceProvider.addInvoice(newInvoice).then((_) {
        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.invoiceDetailsScreen,
              arguments: {'invoice': newInvoice});
          Provider.of<ItemProvider>(context, listen: false)
              .clearSelectedItems();
        }
      });
    } else {
      DialogBoxes().showCreateInvoiceDialog(context);
    }
  }
}
