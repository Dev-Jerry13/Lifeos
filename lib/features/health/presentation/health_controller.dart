import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/local_database.dart';
import '../data/health_metric.dart';

final healthControllerProvider = StateNotifierProvider<HealthController, List<HealthMetric>>((ref) {
  return HealthController(ref.watch(seedHealthProvider));
});

class HealthController extends StateNotifier<List<HealthMetric>> {
  HealthController(super.state);

  List<HealthMetric> get metrics => state;

  void addWater(double liters) {
    state = [
      for (final metric in state)
        if (metric.label == 'Water') metric.copyWith(value: (metric.value + liters).clamp(0, metric.target).toDouble()) else metric,
    ];
  }
}
