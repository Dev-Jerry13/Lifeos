import 'package:flutter_test/flutter_test.dart';
import 'package:lifeos/features/habits/data/habit.dart';
import 'package:lifeos/features/habits/presentation/habits_controller.dart';
import 'package:lifeos/features/health/data/health_metric.dart';
import 'package:lifeos/features/health/presentation/health_controller.dart';
import 'package:lifeos/features/tasks/data/task_item.dart';
import 'package:lifeos/features/tasks/presentation/tasks_controller.dart';

void main() {
  test('seed data powers the local-first dashboard', () {
    expect(TaskItem.seedToday(), hasLength(3));
    expect(Habit.seed().where((habit) => habit.completedToday), isNotEmpty);
  });

  test('task controller can add, complete, and remove tasks offline', () {
    final controller = TasksController(null, []);
    controller.addTask(title: 'Review LifeOS', priority: TaskPriority.high);

    expect(controller.items, hasLength(1));
    final taskId = controller.items.first.id;

    controller.toggle(taskId);
    expect(controller.items.first.isCompleted, isTrue);

    controller.remove(taskId);
    expect(controller.items, isEmpty);
  });

  test('habit and health controllers update local progress instantly', () {
    final habitController = HabitsController(null, Habit.seed());
    habitController.toggle('Meditation');
    expect(habitController.habits.firstWhere((habit) => habit.name == 'Meditation').completedToday, isTrue);

    final healthController = HealthController(null, HealthMetric.seed());
    healthController.addWater(0.25);
    expect(healthController.metrics.first.value, closeTo(1.85, 0.001));
  });
}
