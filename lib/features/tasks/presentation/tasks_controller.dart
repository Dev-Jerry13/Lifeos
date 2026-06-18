import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/local_database.dart';
import '../data/task_item.dart';

final tasksControllerProvider = StateNotifierProvider<TasksController, List<TaskItem>>((ref) {
  return TasksController(ref.watch(seedTasksProvider));
});

class TasksController extends StateNotifier<List<TaskItem>> {
  TasksController(super.state);

  void toggle(String id) {
    state = [
      for (final task in state)
        if (task.id == id) task.copyWith(isCompleted: !task.isCompleted) else task,
    ];
  }
}
