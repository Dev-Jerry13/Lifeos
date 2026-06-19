import 'package:isar/isar.dart';

part 'health_metric.g.dart';

@collection
class HealthMetric {
  Id id = Isar.autoIncrement;
  String label = '';
  double value = 0;
  double target = 0;
  String unit = '';

  double get progress => target == 0 ? 0 : value / target;

  static List<HealthMetric> seed() => [
        HealthMetric()
          ..label = 'Water'
          ..value = 1.6
          ..target = 2.4
          ..unit = 'L',
        HealthMetric()
          ..label = 'Sleep'
          ..value = 7.2
          ..target = 8
          ..unit = 'h',
        HealthMetric()
          ..label = 'Exercise'
          ..value = 32
          ..target = 45
          ..unit = 'min',
      ];
}
