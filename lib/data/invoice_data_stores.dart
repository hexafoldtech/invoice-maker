import 'package:invoice_maker/models/InvoiceModel/invoice_model.dart';

abstract class InvoiceLocalDataSource {
  Future<void> saveInvoice(InvoiceModel invoice);
  InvoiceModel? getInvoice(int id);
  Future<List<InvoiceModel>> getAllInvoices();
  Future<void> deleteInvoice(int id);
  Future<void> updateInvoice(InvoiceModel invoice);
}
