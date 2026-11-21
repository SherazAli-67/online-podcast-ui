class PodcastModel {
  final String id;
  final String title;
  final String author;
  final String cover;
  final String category;
  final String duration;
  final String listened;
  final String currentTime;
  final String totalTime;
  final String profileTab;

  const PodcastModel({
    required this.id,
    required this.title,
    required this.author,
    required this.cover,
    required this.category,
    this.duration = '',
    this.listened = '',
    this.currentTime = '',
    this.totalTime = '',
    this.profileTab = '',
  });
}
