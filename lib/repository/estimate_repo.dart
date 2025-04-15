import 'package:flutter/material.dart';
import '../data/local/datasources/estimate_data_source.dart';
import '../models/EstimateModel/estimate_model.dart';
import '../core/constants/app_strings.dart';

class EstimateRepo {
  final EstimateDataSourceImpl estimateDataSourceImpl =
      EstimateDataSourceImpl();

  Future<List<EstimateModel>> getAllEstimates() async {
    try {
      return await estimateDataSourceImpl.getAllEstimates();
    } catch (e) {
      debugPrint(AppStrings.errorText);
      return [];
    }
  }

  EstimateModel? getEstimate(int id) {
    try {
      return estimateDataSourceImpl.getEstimate(id);
    } catch (e) {
      debugPrint(AppStrings.errorText);
      return null;
    }
  }

  Future<void> saveEstimate(EstimateModel estimate) async {
    try {
      await estimateDataSourceImpl.saveEstimate(estimate);
    } catch (e) {
      debugPrint(AppStrings.errorText);
    }
  }

  Future<void> updateEstimate(EstimateModel estimate) async {
    try {
      await estimateDataSourceImpl.updateEstimate(estimate);
    } catch (e) {
      debugPrint(AppStrings.errorText);
    }
  }

  Future<void> deleteEstimate(int id) async {
    try {
      await estimateDataSourceImpl.deleteEstimate(id);
    } catch (e) {
      debugPrint(AppStrings.errorText);
    }
  }
}
