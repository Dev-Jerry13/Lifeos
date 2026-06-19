import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../core/database/local_database.dart';
import '../data/habit.dart';

final habitsControllerProvider = StateNotifierProvider<HabitsController, List<Habit>>((ref) {
  return HabitsController(ref.read(isarProvider), ref.watch(seedHabitsProvider));
});

final habitsProvider = Provider<List<Habit>>((ref) => ref.watch(habitsControllerProvider));

final habitCompletionProvider = Provider<double>((ref) {
  final habits = ref.watch(habitsProvider);
  if (habits.isEmpty) return 0;
  return habits.where((habit) => habit.completedToday).length / habits.length;
});

class HabitsController extends StateNotifier<List<Habit>> {
  HabitsController(this._isar, super.state);

  final Isar? _isar;

  List<Habit> get habits => state;

  void toggle(String name) {
    final habit = state.firstWhere((h) => h.name == name);
    final wasCompleted = habit.completedToday;
    habit.completedToday = !wasCompleted;
    habit.streak = wasCompleted
        ? (habit.streak - 1).clamp(0, 999) as int
        : habit.streak + 1;
    _isar?.writeTxn(() async => _isar!.habits.put(habit));
    state = [...state];
  }

  void addHabit(String name, {String icon = '\u2728'}) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    final habit = Habit()
      ..name = trimmed
      ..icon = icon;
    _isar?.writeTxn(() async => _isar!.habits.put(habit));
    state = [habit, ...state];
  }
}
