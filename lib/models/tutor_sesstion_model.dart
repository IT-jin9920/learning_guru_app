class TutorSession {
  final String name;
  final String subject;
  final String dateTime;
  final double? rate;
  final String? imagePath;

  TutorSession({
    required this.name,
    required this.subject,
    required this.dateTime,
    this.rate,
    this.imagePath,
  });
}
