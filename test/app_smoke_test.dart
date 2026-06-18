import 'package:flutter_test/flutter_test.dart';
import 'package:lifeos/features/habits/data/habit.dart';
import 'package:lifeos/features/tasks/data/task_item.dart';

void main() {
  test('seed data powers the local-first dashboard', () {
    expect(TaskItem.seedToday(), hasLength(3));
    expect(Habit.seed().where((habit) => habit.completedToday), isNotEmpty);
  });
}
