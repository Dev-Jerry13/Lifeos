import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/local_database.dart';
import '../data/habit.dart';

final habitsControllerProvider = StateNotifierProvider<HabitsController, List<Habit>>((ref) {
  return HabitsController(ref.watch(seedHabitsProvider));
});

final habitsProvider = Provider<List<Habit>>((ref) => ref.watch(habitsControllerProvider));
final habitCompletionProvider = Provider<double>((ref) {
  final habits = ref.watch(habitsProvider);
  if (habits.isEmpty) return 0;
  return habits.where((habit) => habit.completedToday).length / habits.length;
});

class HabitsController extends StateNotifier<List<Habit>> {
  HabitsController(super.state);

  List<Habit> get habits => state;

  void toggle(String name) {
    state = [
      for (final habit in state)
        if (habit.name == name)
          habit.copyWith(
            completedToday: !habit.completedToday,
            streak: habit.completedToday ? (habit.streak - 1).clamp(0, 999) as int : habit.streak + 1,
          )
        else
          habit,
    ];
  }

  void addHabit(String name, {String icon = '✨'}) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    state = [Habit(name: trimmed, icon: icon, streak: 0, completedToday: false), ...state];
  }
}
