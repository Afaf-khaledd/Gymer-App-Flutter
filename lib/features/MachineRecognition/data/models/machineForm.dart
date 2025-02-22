class MachineForm {
  final String machineForm;
  final List<String> machineFormVideo;

  MachineForm({
    required this.machineForm,
    required this.machineFormVideo,
  });

  factory MachineForm.fromJson(Map<String, dynamic> json) {
    return MachineForm(
      machineForm: json["machineForm"],
      machineFormVideo: List<String>.from(json["machineFormVideo"]),
    );
  }
}