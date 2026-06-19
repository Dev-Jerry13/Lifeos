import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/habits/presentation/habits_controller.dart';
import '../../features/journal/presentation/journal_controller.dart';
import '../../features/tasks/data/task_item.dart';
import '../../features/tasks/presentation/tasks_controller.dart';

Future<void> showQuickAddSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => const QuickAddSheet(),
  );
}

class QuickAddSheet extends ConsumerStatefulWidget {
  const QuickAddSheet({super.key});

  @override
  ConsumerState<QuickAddSheet> createState() => _QuickAddSheetState();
}

class _QuickAddSheetState extends ConsumerState<QuickAddSheet> {
  final _controller = TextEditingController();
  String _mode = 'task';
  TaskPriority _priority = TaskPriority.medium;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, bottomInset + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick create', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'task', label: Text('Task'), icon: Icon(Icons.check_rounded)),
              ButtonSegment(value: 'habit', label: Text('Habit'), icon: Icon(Icons.repeat_rounded)),
              ButtonSegment(value: 'journal', label: Text('Journal'), icon: Icon(Icons.edit_note_rounded)),
            ],
            selected: {_mode},
            onSelectionChanged: (value) => setState(() => _mode = value.first),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            minLines: _mode == 'journal' ? 4 : 1,
            maxLines: _mode == 'journal' ? 6 : 1,
            autofocus: true,
            decoration: InputDecoration(
              labelText: _mode == 'journal' ? 'Capture a reflection' : 'Name',
              hintText: _mode == 'task' ? 'e.g. Review weekly plan' : _mode == 'habit' ? 'e.g. Stretching' : 'What happened today?',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          if (_mode == 'task') ...[
            const SizedBox(height: 12),
            DropdownButtonFormField<TaskPriority>(
              value: _priority,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              items: TaskPriority.values
                  .map((priority) => DropdownMenuItem(value: priority, child: Text('${priority.name[0].toUpperCase()}${priority.name.substring(1)} priority')))
                  .toList(),
              onChanged: (value) => setState(() => _priority = value ?? TaskPriority.medium),
            ),
          ],
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Add to LifeOS'),
            ),
          ),
        ],
      ),
    );
  }

  void _save() {
    final text = _controller.text;
    if (_mode == 'task') {
      ref.read(tasksControllerProvider.notifier).addTask(title: text, priority: _priority);
    } else if (_mode == 'habit') {
      ref.read(habitsControllerProvider.notifier).addHabit(text);
    } else {
      ref.read(journalControllerProvider.notifier).addEntry(text: text);
    }
    Navigator.of(context).pop();
  }
}
