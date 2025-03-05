import 'favMachineModel.dart';

class FavoriteModel {
  final List<FavoriteMachineModel> favouriteMachines;

  FavoriteModel({required this.favouriteMachines});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      favouriteMachines: (json['favouriteMachines'] as List<dynamic>?)
          ?.map((item) => FavoriteMachineModel.fromJson(item as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  @override
  String toString() {
    return 'Favourite Machines: ${favouriteMachines.map((m) => m.machineName).join(', ')}';
  }
}