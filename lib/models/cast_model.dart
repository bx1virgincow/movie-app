class CastModel {
  double aspectRatio;
  int height;
  String? iso6391;
  String filePath;
  double voteAverage;
  int voteCount;
  int width;

  CastModel({
    required this.aspectRatio,
    required this.height,
    required this.iso6391,
    required this.filePath,
    required this.voteAverage,
    required this.voteCount,
    required this.width,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      aspectRatio:
          json['aspect_ratio'] ?? 0.0,
      height: json['height'] ?? 0,
      iso6391: json['iso_639_1'] ?? "",
      filePath: json['file_path'] ?? "",
      voteAverage:
          json['vote_average'] ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      width: json['width'] ?? 0,
    );
  }
}
