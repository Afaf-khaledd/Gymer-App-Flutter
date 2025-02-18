class ResponseModel{
  final String message;
  final List<String>? video;

  ResponseModel({required this.message, this.video});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      message: json['response'],
      video: json['machineVideo'] != null && json['machineVideo'].isNotEmpty
          ? List<String>.from(json['machineVideo'])
          : null,
    );
  }
  @override
  String toString() {
    return 'Response{message: $message, video: ${video != null ? video.toString() : "No videos"}}';
  }
}