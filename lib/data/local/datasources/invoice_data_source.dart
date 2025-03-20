import 'package:hive/hive.dart';
import 'package:invoice_maker/core/constants/app_strings.dart';
import '../../invoice_data_stores.dart';
import '../../../models/InvoiceModel/invoice_model.dart';
import '../../../core/constants/hive_box_names.dart';

class InvoiceDataSourceImpl implements InvoiceLocalDataSource {
  late final Box<InvoiceModel> _invoiceBox;
  InvoiceDataSourceImpl() {
    _invoiceBox = Hive.box<InvoiceModel>(HiveBoxNames.invoices);
  }
  @override
  Future<List<InvoiceModel>> getAllInvoices() async {
    return _invoiceBox.values.toList();
  }

  @override
  InvoiceModel? getInvoice(int id) {
    return _invoiceBox.get(id);
  }

  @override
  Future<void> saveInvoice(InvoiceModel invoice) async {
    await _invoiceBox.put(invoice.id, invoice);
  }

  @override
  Future<void> updateInvoice(InvoiceModel invoice) async {
    if (_invoiceBox.containsKey(invoice.id)) {
      await _invoiceBox.put(invoice.id, invoice);
    }
  }

  @override
  Future<void> deleteInvoice(int id) async {
    await _invoiceBox.delete(id);
  }

  @override
  Future<void> updateInvoiceAmount(
      InvoiceModel invoice, double newPaidAmount) async {
    if (_invoiceBox.containsKey(invoice.id)) {
      invoice.paidAmount = newPaidAmount;
      if (invoice.total == newPaidAmount) {
        invoice.status = AppStrings.toggleButtonPaidText;
      }
      await _invoiceBox.put(invoice.id, invoice);
    }
  }
}
