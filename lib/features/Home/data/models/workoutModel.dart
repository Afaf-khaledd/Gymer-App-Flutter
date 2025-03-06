class WorkoutModel {
final Map<String,String> workout;

  WorkoutModel({
    required this.workout
  });

  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
        workout: json["workout"]
    );
  }
}