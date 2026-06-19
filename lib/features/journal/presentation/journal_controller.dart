import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/local_database.dart';
import '../data/journal_entry.dart';

final journalControllerProvider = StateNotifierProvider<JournalController, List<JournalEntry>>((ref) {
  return JournalController(ref.watch(seedJournalProvider));
});

class JournalController extends StateNotifier<List<JournalEntry>> {
  JournalController(super.state);

  void addEntry({required String text, String mood = 'Reflective'}) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    state = [
      JournalEntry(date: DateTime.now(), mood: mood, preview: trimmed),
      ...state,
    ];
  }
}
