import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../features/goals/data/goal.dart';
import '../../features/habits/data/habit.dart';
import '../../features/health/data/health_metric.dart';
import '../../features/journal/data/journal_entry.dart';
import '../../features/tasks/data/task_item.dart';

final isarProvider = Provider<Isar>((ref) => throw UnimplementedError());

final seedTasksProvider = Provider<List<TaskItem>>((ref) => TaskItem.seedToday());

final seedHabitsProvider = Provider<List<Habit>>((ref) => Habit.seed());

final seedJournalProvider = Provider<List<JournalEntry>>((ref) => JournalEntry.seed());

final seedHealthProvider = Provider<List<HealthMetric>>((ref) => HealthMetric.seed());

final seedGoalsProvider = Provider<List<Goal>>((ref) => Goal.seed());
