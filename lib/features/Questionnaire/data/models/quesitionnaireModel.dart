class QuestionnaireModel {
  final int? goalWeight;
  final int? currentWeight;
  final String? gender;
  final int? height;
  final int? age;
  final String? activityLevel;
  final String? maingoal;
  final String? duration;
  final List<String>? workoutDays;
  final String? fittnesslevel;

  QuestionnaireModel({
    this.goalWeight,
    this.currentWeight,
    this.gender,
    this.height,
    this.age,
    this.activityLevel,
    this.maingoal,
    this.duration,
    this.workoutDays,
    this.fittnesslevel,
  });

  Map<String, dynamic> toJson() {
    return {
      "goalWeight": goalWeight,
      "currentWeight": currentWeight,
      "gender": gender,
      "height": height,
      "age": age,
      "activityLevel": activityLevel,
      "maingoal": maingoal,
      "duration": duration,
      "workoutDays": workoutDays,
      "fittnesslevel": fittnesslevel,
    };
  }
  QuestionnaireModel copyWith({
    int? goalWeight,
    int? currentWeight,
    String? gender,
    int? height,
    int? age,
    String? activityLevel,
    String? maingoal,
    String? duration,
    List<String>? workoutDays,
    String? fittnesslevel,
  }) {
    return QuestionnaireModel(
      goalWeight: goalWeight ?? this.goalWeight,
      currentWeight: currentWeight ?? this.currentWeight,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      age: age ?? this.age,
      activityLevel: activityLevel ?? this.activityLevel,
      maingoal: maingoal ?? this.maingoal,
      duration: duration ?? this.duration,
      workoutDays: workoutDays ?? this.workoutDays,
      fittnesslevel: fittnesslevel ?? this.fittnesslevel,
    );
  }
}
