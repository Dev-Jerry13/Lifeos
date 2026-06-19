import 'package:isar/isar.dart';

part 'task_item.g.dart';

enum TaskPriority { low, medium, high }

@collection
class TaskItem {
  Id id = Isar.autoIncrement;
  String title = '';
  String category = '';
  late DateTime dueDate;
  @enumerated
  TaskPriority priority = TaskPriority.medium;
  bool isCompleted = false;

  static List<TaskItem> seedToday() {
    final now = DateTime.now();
    return [
      TaskItem()
        ..title = 'Plan weekly focus'
        ..category = 'Work'
        ..dueDate = now
        ..priority = TaskPriority.high,
      TaskItem()
        ..title = 'Read 20 pages'
        ..category = 'Growth'
        ..dueDate = now
        ..priority = TaskPriority.medium,
      TaskItem()
        ..title = 'Evening reset'
        ..category = 'Personal'
        ..dueDate = now
        ..priority = TaskPriority.low,
    ];
  }
}
