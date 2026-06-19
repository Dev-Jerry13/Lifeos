import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../core/database/local_database.dart';
import '../data/task_item.dart';

final tasksControllerProvider = StateNotifierProvider<TasksController, List<TaskItem>>((ref) {
  return TasksController(ref.read(isarProvider), ref.watch(seedTasksProvider));
});

class TasksController extends StateNotifier<List<TaskItem>> {
  TasksController(this._isar, super.state);

  final Isar? _isar;

  List<TaskItem> get items => state;

  void addTask({
    required String title,
    String category = 'Inbox',
    TaskPriority priority = TaskPriority.medium,
    DateTime? dueDate,
  }) {
    final trimmed = title.trim();
    if (trimmed.isEmpty) return;
    final task = TaskItem()
      ..title = trimmed
      ..category = category.trim().isEmpty ? 'Inbox' : category.trim()
      ..dueDate = dueDate ?? DateTime.now()
      ..priority = priority;
    _isar?.writeTxn(() async => _isar!.taskItems.put(task));
    state = [task, ...state];
  }

  void toggle(int id) {
    final task = state.firstWhere((t) => t.id == id);
    task.isCompleted = !task.isCompleted;
    _isar?.writeTxn(() async => _isar!.taskItems.put(task));
    state = [...state];
  }

  void remove(int id) {
    _isar?.writeTxn(() async => _isar!.taskItems.delete(id));
    state = state.where((task) => task.id != id).toList(growable: false);
  }
}
