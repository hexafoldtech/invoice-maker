import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/estimate_provider.dart';
import '../../providers/client_provider.dart';
import '../../providers/item_provider.dart';
import '../../view/new_estimate_screen/preview_screen.dart';
import '../definitions/route_names.dart';
import 'dialog_boxes.dart';

class NewEstimateUtils {
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
      Navigator.pushNamed(context, RouteNames.estimatePreviewScreen,
          arguments: {'type': PreviewType.preview});
    } else {
      DialogBoxes().showPreviewDialog(context);
    }
  }

  void onSaveEstimate(BuildContext context) {
    if (Provider.of<ClientProvider>(context, listen: false).selectedClient !=
            null &&
        Provider.of<ItemProvider>(context, listen: false)
            .selectedItems
            .isNotEmpty) {
      var estimateProvider =
          Provider.of<EstimateProvider>(context, listen: false);
      var newEstimate = estimateProvider.createEstimateModel();
      estimateProvider.addEstimate(newEstimate).then((_) {
        if (context.mounted) {
          Navigator.pushNamed(context, RouteNames.estimateDetailsScreen,
              arguments: {'estimate': newEstimate});
          Provider.of<ItemProvider>(context, listen: false)
              .clearSelectedItems();
          Provider.of<ClientProvider>(context, listen: false)
              .clearSelectedClient();
        }
      });
    } else {
      DialogBoxes().showCreateInvoiceDialog(context);
    }
  }
}
