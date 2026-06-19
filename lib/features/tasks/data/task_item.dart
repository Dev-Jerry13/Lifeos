enum TaskPriority { low, medium, high }

class TaskItem {
  const TaskItem({
    required this.id,
    required this.title,
    required this.category,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String category;
  final DateTime dueDate;
  final TaskPriority priority;
  final bool isCompleted;

  TaskItem copyWith({bool? isCompleted}) => TaskItem(
        id: id,
        title: title,
        category: category,
        dueDate: dueDate,
        priority: priority,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  static List<TaskItem> seedToday() {
    final now = DateTime.now();
    return [
      TaskItem(id: '1', title: 'Plan weekly focus', category: 'Work', dueDate: now, priority: TaskPriority.high),
      TaskItem(id: '2', title: 'Read 20 pages', category: 'Growth', dueDate: now, priority: TaskPriority.medium),
      TaskItem(id: '3', title: 'Evening reset', category: 'Personal', dueDate: now, priority: TaskPriority.low),
    ];
  }
}
