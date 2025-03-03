class FavoriteModel {
  final List<String> favouriteMachines;

  FavoriteModel({required this.favouriteMachines});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      favouriteMachines: List<String>.from(json['favouriteMachines'] ?? []),
    );
  }
  @override
  String toString() {
    return 'Favourite Machines: ${favouriteMachines.join(', ')}';
  }
}