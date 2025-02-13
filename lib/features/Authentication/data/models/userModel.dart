class UserModel {
  final String fullName;
  final String userName;
  final String email;
  final String token;
  int? currentWeight;
  String? profileUrl;


  UserModel({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.token,
    this.currentWeight,
    this.profileUrl
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String token) {
    return UserModel(
      fullName: json['fullName'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      currentWeight: json['currentWeight'] ?? 0,
      profileUrl: json['photourl'] ?? '',
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
      'photourl': profileUrl
    };
  }
}