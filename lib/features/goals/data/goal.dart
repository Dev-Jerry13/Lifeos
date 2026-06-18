class Goal {
  const Goal({required this.title, required this.progress, required this.milestones});
  final String title;
  final double progress;
  final int milestones;

  static List<Goal> seed() => const [
        Goal(title: 'Ship LifeOS MVP', progress: 0.64, milestones: 7),
        Goal(title: 'Run a 10K', progress: 0.42, milestones: 5),
      ];
}
