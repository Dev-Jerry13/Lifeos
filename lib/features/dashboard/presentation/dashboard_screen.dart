import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/database/local_database.dart';
import '../../../core/widgets/animated_entrance.dart';
import '../../../core/widgets/animated_progress_ring.dart';
import '../../../core/widgets/premium_card.dart';
import '../../habits/presentation/habits_controller.dart';
import '../../health/presentation/health_controller.dart';
import '../../tasks/presentation/tasks_controller.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksControllerProvider);
    final habits = ref.watch(habitsProvider);
    final health = ref.watch(healthControllerProvider);
    final goals = ref.watch(seedGoalsProvider);
    final completion = ref.watch(habitCompletionProvider);
    final doneTasks = tasks.where((task) => task.isCompleted).length;
    final dailyProgress = (doneTasks / tasks.length * 0.55) + (completion * 0.45);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      children: [
        Text('Good morning, Alex', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        Text(DateFormat('EEEE, MMMM d').format(DateTime.now()), style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 24),
        AnimatedEntrance(
          child: PremiumCard(
            accented: true,
            child: Row(
            children: [
              AnimatedProgressRing(value: dailyProgress, label: 'today'),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Daily operating score', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text('$doneTasks of ${tasks.length} tasks complete · ${(completion * 100).round()}% habits done'),
                  ],
                ),
              ),
            ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const AnimatedEntrance(
          delay: Duration(milliseconds: 60),
          child: _SectionTitle(title: 'Today\'s focus', action: 'View all'),
        ),
        ...tasks.map((task) => AnimatedEntrance(
              delay: Duration(milliseconds: 90),
              child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: PremiumCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: CheckboxListTile(
                  value: task.isCompleted,
                  onChanged: (_) => ref.read(tasksControllerProvider.notifier).toggle(task.id),
                  title: Text(task.title),
                  subtitle: Text('${task.category} · ${task.priority.name} priority'),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              ),
            )),
        const SizedBox(height: 8),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 120),
          child: Row(
          children: [
            Expanded(child: _MetricCard(title: 'Water', value: '${health.first.value.toStringAsFixed(1)}/${health.first.target}L', icon: Icons.water_drop_rounded, onTap: () => ref.read(healthControllerProvider.notifier).addWater(0.25))),
            const SizedBox(width: 12),
            const Expanded(child: _MetricCard(title: 'Mood', value: 'Focused', icon: Icons.auto_awesome_rounded)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 160),
          child: PremiumCard(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Habit momentum', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: habits.map((habit) => Chip(label: Text('${habit.icon} ${habit.name} · ${habit.streak}d'))).toList(),
              ),
            ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        AnimatedEntrance(
          delay: const Duration(milliseconds: 200),
          child: PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('North star goal', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                Text(goals.first.title),
                const SizedBox(height: 10),
                LinearProgressIndicator(value: goals.first.progress, minHeight: 10, borderRadius: BorderRadius.circular(99)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const AnimatedEntrance(
          delay: Duration(milliseconds: 240),
          child: PremiumCard(
            child: Text('“Small systems, repeated daily, become a calmer life.”'),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.action});
  final String title;
  final String action;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
            Text(action, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700)),
          ],
        ),
      );
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.title, required this.value, required this.icon, this.onTap});
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => PremiumCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 12),
            Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
            Text(title),
          ],
        ),
      );
}
