class Achievement {
  final int points;
  final int achievementsLevel;
  final int pointsToNextLevel;

  Achievement({
    required this.points,
    required this.achievementsLevel,
    required this.pointsToNextLevel,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
        points: json['points'],
        achievementsLevel: json['achievementslevel'],
        pointsToNextLevel: json['pointstonextlevel']);
  }
}
