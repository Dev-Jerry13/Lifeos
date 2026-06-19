class JournalEntry {
  const JournalEntry({required this.date, required this.mood, required this.preview});
  final DateTime date;
  final String mood;
  final String preview;

  static List<JournalEntry> seed() => [
        JournalEntry(date: DateTime.now(), mood: 'Focused', preview: 'Today I am optimizing for calm execution and deep work.'),
      ];
}
