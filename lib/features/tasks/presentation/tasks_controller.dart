import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/local_database.dart';
import '../data/task_item.dart';

final tasksControllerProvider = StateNotifierProvider<TasksController, List<TaskItem>>((ref) {
  return TasksController(ref.watch(seedTasksProvider));
});

class TasksController extends StateNotifier<List<TaskItem>> {
  TasksController(super.state);

  List<TaskItem> get items => state;

  void addTask({
    required String title,
    String category = 'Inbox',
    TaskPriority priority = TaskPriority.medium,
    DateTime? dueDate,
  }) {
    final trimmed = title.trim();
    if (trimmed.isEmpty) return;
    state = [
      TaskItem(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: trimmed,
        category: category.trim().isEmpty ? 'Inbox' : category.trim(),
        dueDate: dueDate ?? DateTime.now(),
        priority: priority,
      ),
      ...state,
    ];
  }

  void toggle(String id) {
    state = [
      for (final task in state)
        if (task.id == id) task.copyWith(isCompleted: !task.isCompleted) else task,
    ];
  }

  void remove(String id) {
    state = state.where((task) => task.id != id).toList(growable: false);
  }
}
