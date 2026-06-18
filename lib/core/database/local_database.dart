import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/goals/data/goal.dart';
import '../../features/habits/data/habit.dart';
import '../../features/health/data/health_metric.dart';
import '../../features/journal/data/journal_entry.dart';
import '../../features/tasks/data/task_item.dart';

final localDatabaseProvider = Provider<LocalDatabase>((ref) => LocalDatabase());

class LocalDatabase {
  LocalDatabase();

  /// Placeholder for the production Isar database initialization.
  /// The app is intentionally local-first: repositories persist instantly on
  /// device and future cloud sync can subscribe to these local mutations.
  Future<void> open() async {
    await SharedPreferences.getInstance();
  }
}

final seedTasksProvider = Provider<List<TaskItem>>((ref) => TaskItem.seedToday());
final seedHabitsProvider = Provider<List<Habit>>((ref) => Habit.seed());
final seedJournalProvider = Provider<List<JournalEntry>>((ref) => JournalEntry.seed());
final seedHealthProvider = Provider<List<HealthMetric>>((ref) => HealthMetric.seed());
final seedGoalsProvider = Provider<List<Goal>>((ref) => Goal.seed());
