import 'package:flutter/material.dart';
import 'package:online_podcast_app_ui/core/app_data.dart';
import 'package:online_podcast_app_ui/core/models/podcast_model.dart';

class PlayerProvider extends ChangeNotifier {
  final String episodeId;
  bool _isPlaying = false;
  bool _isRepeat = false;

  PlayerProvider({required this.episodeId});

  PodcastModel get podcast => AppData.podcastById(episodeId);

  bool get isPlaying => _isPlaying;

  bool get isRepeat => _isRepeat;

  double get progress {
    final current = _secondsFromLabel(podcast.currentTime);
    final total = _secondsFromLabel(podcast.totalTime);
    if (total <= 0) return 0;
    return (current / total).clamp(0.0, 1.0);
  }

  void togglePlay() {
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void toggleRepeat() {
    _isRepeat = !_isRepeat;
    notifyListeners();
  }

  int _secondsFromLabel(String label) {
    final parts = label.split(':');
    if (parts.length != 2) return 0;
    final minutes = int.tryParse(parts[0]) ?? 0;
    final seconds = int.tryParse(parts[1]) ?? 0;
    return (minutes * 60) + seconds;
  }
}
