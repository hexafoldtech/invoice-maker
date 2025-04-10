import '../models/EstimateModel/estimate_model.dart';

abstract class EstimateLocalDataSource {
  Future<void> saveEstimate(EstimateModel estimate);
  EstimateModel? getEstimate(int id);
  Future<List<EstimateModel>> getAllEstimates();
  Future<void> deleteEstimate(int id);
  Future<void> updateEstimate(EstimateModel estimate);
}