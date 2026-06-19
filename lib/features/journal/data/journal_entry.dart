import 'package:isar/isar.dart';

part 'journal_entry.g.dart';

@collection
class JournalEntry {
  Id id = Isar.autoIncrement;
  late DateTime date;
  String mood = '';
  String preview = '';

  static List<JournalEntry> seed() => [
        JournalEntry()
          ..date = DateTime.now()
          ..mood = 'Focused'
          ..preview =
              'Today I am optimizing for calm execution and deep work.',
      ];
}
