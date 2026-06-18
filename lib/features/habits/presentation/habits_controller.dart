import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/local_database.dart';
import '../data/habit.dart';

final habitsProvider = Provider<List<Habit>>((ref) => ref.watch(seedHabitsProvider));
final habitCompletionProvider = Provider<double>((ref) {
  final habits = ref.watch(habitsProvider);
  if (habits.isEmpty) return 0;
  return habits.where((habit) => habit.completedToday).length / habits.length;
});
