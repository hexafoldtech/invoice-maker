import 'package:flutter/material.dart';
import '../models/InvoiceModel/invoice_model.dart';
import '../data/local/datasources/invoice_data_source.dart';
import '../core/constants/app_strings.dart';

class InvoiceRepo {
  final InvoiceDataSourceImpl invoiceDataSourceImpl = InvoiceDataSourceImpl();

  Future<List<InvoiceModel>> getAllInvoices() async {
    try {
      return await invoiceDataSourceImpl.getAllInvoices();
    } catch (e) {
      debugPrint(AppStrings.errorText);
      return [];
    }
  }

  InvoiceModel? getInvoice(int id) {
    try {
      return invoiceDataSourceImpl.getInvoice(id);
    } catch (e) {
      debugPrint(AppStrings.errorText);
      return null;
    }
  }

  Future<void> saveInvoice(InvoiceModel invoice) async {
    try {
      await invoiceDataSourceImpl.saveInvoice(invoice);
    } catch (e) {
      debugPrint(AppStrings.errorText);
    }
  }

  Future<void> updateInvoice(InvoiceModel invoice) async {
    try {
      await invoiceDataSourceImpl.updateInvoice(invoice);
    } catch (e) {
      debugPrint(AppStrings.errorText);
    }
  }

  Future<void> deleteInvoice(int id) async {
    try {
      await invoiceDataSourceImpl.deleteInvoice(id);
    } catch (e) {
      debugPrint(AppStrings.errorText);
    }
  }
}
