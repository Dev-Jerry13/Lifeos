import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import 'app/lifeos_app.dart';
import 'core/database/isar_service.dart';
import 'core/database/local_database.dart';
import 'features/goals/data/goal.dart';
import 'features/habits/data/habit.dart';
import 'features/health/data/health_metric.dart';
import 'features/journal/data/journal_entry.dart';
import 'features/tasks/data/task_item.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isar = await IsarService.open();
  await IsarService.seedIfEmpty(isar);

  final tasks = await isar.taskItems.where().findAll();
  final habits = await isar.habits.where().findAll();
  final healthMetrics = await isar.healthMetrics.where().findAll();
  final journalEntrys = await isar.journalEntrys.where().findAll();
  final goals = await isar.goals.where().findAll();

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
        seedTasksProvider.overrideWithValue(tasks),
        seedHabitsProvider.overrideWithValue(habits),
        seedHealthProvider.overrideWithValue(healthMetrics),
        seedJournalProvider.overrideWithValue(journalEntrys),
        seedGoalsProvider.overrideWithValue(goals),
      ],
      child: const LifeOSApp(),
    ),
  );
}
