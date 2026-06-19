import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../core/database/local_database.dart';
import '../data/journal_entry.dart';

final journalControllerProvider = StateNotifierProvider<JournalController, List<JournalEntry>>((ref) {
  return JournalController(ref.read(isarProvider), ref.watch(seedJournalProvider));
});

class JournalController extends StateNotifier<List<JournalEntry>> {
  JournalController(this._isar, super.state);

  final Isar? _isar;

  void addEntry({required String text, String mood = 'Reflective'}) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    final entry = JournalEntry()
      ..date = DateTime.now()
      ..mood = mood
      ..preview = trimmed;
    _isar?.writeTxn(() async => _isar!.journalEntrys.put(entry));
    state = [entry, ...state];
  }
}
