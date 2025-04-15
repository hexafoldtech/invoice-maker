import 'package:hive/hive.dart';
import 'package:invoice_maker/models/EstimateModel/estimate_model.dart';
import '../../estimate_data_stores.dart';
import '../../../core/constants/hive_box_names.dart';

class EstimateDataSourceImpl implements EstimateLocalDataSource {
  late final Box<EstimateModel> _estimateBox;
  EstimateDataSourceImpl() {
    _estimateBox = Hive.box<EstimateModel>(HiveBoxNames.estimates);
  }

  @override
  Future<List<EstimateModel>> getAllEstimates() async {
    return _estimateBox.values.toList();
  }

  @override
  EstimateModel? getEstimate(int id) {
    return _estimateBox.get(id);
  }

  @override
  Future<void> saveEstimate(EstimateModel estimate) async {
    await _estimateBox.put(estimate.id, estimate);
  }

  @override
  Future<void> updateEstimate(EstimateModel estimate) async {
    if (_estimateBox.containsKey(estimate.id)) {
      await _estimateBox.put(estimate.id, estimate);
    }
  }

  @override
  Future<void> deleteEstimate(int id) async {
    await _estimateBox.delete(id);
  }
}
