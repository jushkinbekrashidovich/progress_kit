

class ProgressModel {
  final String title;

  final String startDate;
  final String endDate;

  ProgressModel({
    required this.title,

    required this.startDate,
    required this.endDate,
  });

  // Convert Progress object to JSON
  Map<String, dynamic> toJson() => {
    'title': title,

    'startDate': startDate,
    'endDate': endDate,
  };

  // Create Progress object from JSON
  factory ProgressModel.fromJson(Map<String, dynamic> json) => ProgressModel(
    title: json['title'],

    startDate: json['startDate'],
    endDate: json['endDate'],
  );
}