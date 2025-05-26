class UserModel {
  final String fullName;
  final String userName;
  final String email;
  final String token;
  int? currentWeight;
  String? profileUrl;
  String? workoutPlan;
  int? goalWeight;
  String? gender;
  int? height;
  int? age;
  String? activityLevel;
  String? maingoal;
  String? duration;
  List<String>? workoutDays;
  List<String>? injuries;
  String? fittnesslevel;

  UserModel({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.token,
    this.currentWeight,
    this.profileUrl,
    this.workoutPlan,
    this.goalWeight,
    this.gender,
    this.height,
    this.age,
    this.activityLevel,
    this.maingoal,
    this.duration,
    this.workoutDays,
    this.injuries,
    this.fittnesslevel,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String token) {
    return UserModel(
      fullName: json['fullName'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      currentWeight: json['currentWeight'] ?? 0,
      profileUrl: json['photourl'] ?? '',
      workoutPlan: json['workoutplan']?.toString(),
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      goalWeight: json['goalWeight'] ?? 0,
      height: json['height'] ?? 0,
      activityLevel: json['activityLevel'] ?? '',
      maingoal: json['maingoal'] ?? '',
      duration: json['duration'] ?? '',
      workoutDays: (json['workoutDays'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      injuries: (json['injuries'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      fittnesslevel: json['fittnesslevel'] ?? '',
      token: token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'token': token,
      'currentWeight': currentWeight,
      'photourl': profileUrl,
      'workoutPlan':workoutPlan,
      "goalWeight": goalWeight,
      "gender": gender,
      "height": height,
      "age": age,
      "activityLevel": activityLevel,
      "maingoal": maingoal,
      "duration": duration,
      "workoutDays": workoutDays,
      "injuries": injuries,
      "fittnesslevel": fittnesslevel,
    };
  }
}