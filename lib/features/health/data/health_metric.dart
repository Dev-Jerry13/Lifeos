class HealthMetric {
  const HealthMetric({required this.label, required this.value, required this.target, required this.unit});
  final String label;
  final double value;
  final double target;
  final String unit;

  double get progress => target == 0 ? 0 : value / target;

  HealthMetric copyWith({double? value}) => HealthMetric(
        label: label,
        value: value ?? this.value,
        target: target,
        unit: unit,
      );

  static List<HealthMetric> seed() => const [
        HealthMetric(label: 'Water', value: 1.6, target: 2.4, unit: 'L'),
        HealthMetric(label: 'Sleep', value: 7.2, target: 8, unit: 'h'),
        HealthMetric(label: 'Exercise', value: 32, target: 45, unit: 'min'),
      ];
}
