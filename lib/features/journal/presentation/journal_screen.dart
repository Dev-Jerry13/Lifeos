import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/local_database.dart';
import '../../../core/widgets/premium_card.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(seedJournalProvider);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      children: [
        Text('Journal', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 16),
        SearchBar(hintText: 'Search entries, moods, memories'),
        const SizedBox(height: 16),
        PremiumCard(
          child: TextField(
            minLines: 5,
            maxLines: 8,
            decoration: InputDecoration(
              hintText: 'What made today meaningful?',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
              filled: true,
            ),
          ),
        ),
        const SizedBox(height: 16),
        for (final entry in entries)
          PremiumCard(
            child: ListTile(
              title: Text(entry.mood),
              subtitle: Text(entry.preview),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
      ],
    );
  }
}
