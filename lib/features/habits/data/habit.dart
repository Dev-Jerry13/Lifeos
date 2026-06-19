import 'package:isar/isar.dart';

part 'habit.g.dart';

@collection
class Habit {
  Id id = Isar.autoIncrement;
  String name = '';
  String icon = '';
  int streak = 0;
  bool completedToday = false;

  static List<Habit> seed() => [
        Habit()
          ..name = 'Exercise'
          ..icon = '\u{1F3C3}'
          ..streak = 12
          ..completedToday = true,
        Habit()
          ..name = 'Reading'
          ..icon = '\u{1F4DA}'
          ..streak = 8
          ..completedToday = true,
        Habit()
          ..name = 'Meditation'
          ..icon = '\u{1F9D8}'
          ..streak = 5
          ..completedToday = false,
        Habit()
          ..name = 'Coding'
          ..icon = '\u{1F4BB}'
          ..streak = 21
          ..completedToday = true,
        Habit()
          ..name = 'Sleep'
          ..icon = '\u{1F319}'
          ..streak = 4
          ..completedToday = false,
        Habit()
          ..name = 'Water'
          ..icon = '\u{1F4A7}'
          ..streak = 15
          ..completedToday = true,
      ];
}
