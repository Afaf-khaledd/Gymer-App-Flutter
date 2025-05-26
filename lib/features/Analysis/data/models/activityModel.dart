class ActivityModel {
  final String month;
  final double lastPercentage;
  final List<MonthlyProgress> monthlyProgress;
  final List<PercentageHistory> percentageHistory;
  final double points;
  final bool monthFinished;

  ActivityModel({
    required this.month,
    required this.lastPercentage,
    required this.monthlyProgress,
    required this.percentageHistory,
    required this.points,
    required this.monthFinished,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      month: json['month'] ?? '',
      lastPercentage: (json['lastPercentage'] as num?)?.toDouble() ?? 0.0,
      monthlyProgress: (json['monthlyProgress'] as List?)
          ?.map((e) => MonthlyProgress.fromJson(e))
          .toList() ??
          [],
      percentageHistory: (json['percentageHistory'] as List?)
          ?.map((e) => PercentageHistory.fromJson(e))
          .toList() ??
          [],
      points: (json['points'] as num?)?.toDouble() ?? 0.0,
      monthFinished: json['Monthfinished'] ?? false,
    );
  }
}

class MonthlyProgress {
  final String month;
  final int percentage;

  MonthlyProgress({
    required this.month,
    required this.percentage,
  });

  factory MonthlyProgress.fromJson(Map<String, dynamic> json) {
    return MonthlyProgress(
      month: json['month'] ?? '',
      percentage: json['percentage'] ?? 0,
    );
  }
}

class PercentageHistory {
  final String day;
  final dynamic percentage;

  PercentageHistory({
    required this.day,
    required this.percentage,
  });

  factory PercentageHistory.fromJson(Map<String, dynamic> json) {
    return PercentageHistory(
      day: json['day'] ?? '',
      percentage: (json['percentage']),
    );
  }
}
