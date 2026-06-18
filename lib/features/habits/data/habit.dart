class Habit {
  const Habit({required this.name, required this.icon, required this.streak, required this.completedToday});

  final String name;
  final String icon;
  final int streak;
  final bool completedToday;

  static List<Habit> seed() => const [
        Habit(name: 'Exercise', icon: '🏃', streak: 12, completedToday: true),
        Habit(name: 'Reading', icon: '📚', streak: 8, completedToday: true),
        Habit(name: 'Meditation', icon: '🧘', streak: 5, completedToday: false),
        Habit(name: 'Coding', icon: '💻', streak: 21, completedToday: true),
        Habit(name: 'Sleep', icon: '🌙', streak: 4, completedToday: false),
        Habit(name: 'Water', icon: '💧', streak: 15, completedToday: true),
      ];
}
