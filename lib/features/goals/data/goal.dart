import 'package:isar/isar.dart';

part 'goal.g.dart';

@collection
class Goal {
  Id id = Isar.autoIncrement;
  String title = '';
  double progress = 0;
  int milestones = 0;

  static List<Goal> seed() => [
        Goal()
          ..title = 'Ship LifeOS MVP'
          ..progress = 0.64
          ..milestones = 7,
        Goal()
          ..title = 'Run a 10K'
          ..progress = 0.42
          ..milestones = 5,
      ];
}
