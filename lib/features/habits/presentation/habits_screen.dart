import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/premium_card.dart';
import 'habits_controller.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitsProvider);
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 14, crossAxisSpacing: 14),
      itemCount: habits.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Align(
            alignment: Alignment.centerLeft,
            child: Text('Habits', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
          );
        }
        final habit = habits[index - 1];
        return PremiumCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(habit.icon, style: const TextStyle(fontSize: 34)),
              Text(habit.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
              Text('${habit.streak} day streak'),
              LinearProgressIndicator(value: habit.completedToday ? 1 : 0.45, borderRadius: BorderRadius.circular(99)),
            ],
          ),
        );
      },
    );
  }
}
