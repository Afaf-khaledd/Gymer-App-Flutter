class FavoriteMachineModel {
  final String machineName;
  final String machineImage;
  final List<String> machineVideos;

  FavoriteMachineModel({
    required this.machineImage,
    required this.machineName,
    required this.machineVideos,
  });

  factory FavoriteMachineModel.fromJson(Map<String, dynamic> json) {
    return FavoriteMachineModel(
      machineName: json["machineName"],
      machineImage: json["machineImage"],
      machineVideos: (json["machineVideo"] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [],
    );
  }
}
