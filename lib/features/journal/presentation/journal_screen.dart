import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/premium_card.dart';
import 'journal_controller.dart';

class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  final _draftController = TextEditingController();
  String _mood = 'Focused';

  @override
  void dispose() {
    _draftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(journalControllerProvider);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      children: [
        Text('Journal', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900)),
        const SizedBox(height: 16),
        const SearchBar(hintText: 'Search entries, moods, memories'),
        const SizedBox(height: 16),
        PremiumCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                children: ['Focused', 'Calm', 'Energized', 'Reflective']
                    .map((mood) => ChoiceChip(label: Text(mood), selected: _mood == mood, onSelected: (_) => setState(() => _mood = mood)))
                    .toList(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _draftController,
                minLines: 5,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'What made today meaningful?',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                  filled: true,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: _saveEntry,
                  icon: const Icon(Icons.save_rounded),
                  label: const Text('Save entry'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        for (final entry in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: PremiumCard(
              child: ListTile(
                title: Text(entry.mood),
                subtitle: Text(entry.preview),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            ),
          ),
      ],
    );
  }

  void _saveEntry() {
    ref.read(journalControllerProvider.notifier).addEntry(text: _draftController.text, mood: _mood);
    _draftController.clear();
  }
}
