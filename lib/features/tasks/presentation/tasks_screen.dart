import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/premium_card.dart';
import 'tasks_controller.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksControllerProvider);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      children: [
        Text('Tasks', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 16),
        SegmentedButton<String>(
          segments: const [
            ButtonSegment(value: 'day', label: Text('Day')),
            ButtonSegment(value: 'week', label: Text('Week')),
            ButtonSegment(value: 'month', label: Text('Month')),
          ],
          selected: const {'day'},
        ),
        const SizedBox(height: 16),
        for (final task in tasks)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Dismissible(
              key: ValueKey(task.id),
              onDismissed: (_) => ref.read(tasksControllerProvider.notifier).remove(task.id),
              background: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 24),
                decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(28)),
                child: const Icon(Icons.done_rounded, color: Colors.white),
              ),
              child: PremiumCard(
                child: ListTile(
                  leading: Checkbox(value: task.isCompleted, onChanged: (_) => ref.read(tasksControllerProvider.notifier).toggle(task.id)),
                  title: Text(task.title),
                  subtitle: Text('${task.category} · ${task.priority.name}'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
