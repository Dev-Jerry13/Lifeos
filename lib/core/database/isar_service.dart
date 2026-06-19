import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/goals/data/goal.dart';
import '../../features/habits/data/habit.dart';
import '../../features/health/data/health_metric.dart';
import '../../features/journal/data/journal_entry.dart';
import '../../features/tasks/data/task_item.dart';

class IsarService {
  static Future<Isar> open() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [
        TaskItemSchema,
        HabitSchema,
        HealthMetricSchema,
        JournalEntrySchema,
        GoalSchema,
      ],
      directory: dir.path,
    );
  }

  static Future<void> seedIfEmpty(Isar isar) async {
    final taskCount = await isar.taskItems.where().count();
    if (taskCount > 0) return;

    await isar.writeTxn(() async {
      for (final task in TaskItem.seedToday()) {
        await isar.taskItems.put(task);
      }
      for (final habit in Habit.seed()) {
        await isar.habits.put(habit);
      }
      for (final metric in HealthMetric.seed()) {
        await isar.healthMetrics.put(metric);
      }
      for (final entry in JournalEntry.seed()) {
        await isar.journalEntrys.put(entry);
      }
      for (final goal in Goal.seed()) {
        await isar.goals.put(goal);
      }
    });
  }
}
