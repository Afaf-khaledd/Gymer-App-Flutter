import 'machineForm.dart';

class MachineModel{
  final String machineName;
  final List<String>? machineVideo;
  final List<MachineForm>? machineForms;

  MachineModel({
    required this.machineName,
    this.machineVideo,
    this.machineForms,
  });

  factory MachineModel.fromJson(Map<String, dynamic> json) {
    return MachineModel(
      machineName: json["machineName"],
      machineVideo: json["machineVideo"] != null
          ? List<String>.from(json["machineVideo"])
          : null,
      machineForms: json["machineForms"] != null
          ? (json["machineForms"] as List)
          .map((form) => MachineForm.fromJson(form))
          .toList()
          : null,
    );
  }
}