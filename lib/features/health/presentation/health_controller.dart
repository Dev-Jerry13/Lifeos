import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../core/database/local_database.dart';
import '../data/health_metric.dart';

final healthControllerProvider = StateNotifierProvider<HealthController, List<HealthMetric>>((ref) {
  return HealthController(ref.read(isarProvider), ref.watch(seedHealthProvider));
});

class HealthController extends StateNotifier<List<HealthMetric>> {
  HealthController(this._isar, super.state);

  final Isar? _isar;

  List<HealthMetric> get metrics => state;

  void addWater(double liters) {
    for (final metric in state) {
      if (metric.label == 'Water') {
        metric.value = (metric.value + liters).clamp(0, metric.target).toDouble();
        _isar?.writeTxn(() async => _isar!.healthMetrics.put(metric));
        break;
      }
    }
    state = [...state];
  }
}
