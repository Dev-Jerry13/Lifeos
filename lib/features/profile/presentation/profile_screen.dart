import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/local_database.dart';
import '../../../core/widgets/premium_card.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goals = ref.watch(seedGoalsProvider);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      children: [
        Text('Profile', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 16),
        const PremiumCard(child: ListTile(leading: CircleAvatar(child: Text('A')), title: Text('Alex'), subtitle: Text('Local-first mode · sync disabled'))),
        const SizedBox(height: 16),
        Text('Goals', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        for (final goal in goals)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PremiumCard(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(goal.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 10),
                LinearProgressIndicator(value: goal.progress, minHeight: 10, borderRadius: BorderRadius.circular(99)),
                const SizedBox(height: 8),
                Text('${(goal.progress * 100).round()}% · ${goal.milestones} milestones'),
              ]),
            ),
          ),
      ],
    );
  }
}
