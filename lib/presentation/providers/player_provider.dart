import 'dart:async';

import 'package:flutter/material.dart';
import 'package:online_podcast_app_ui/constants/number_constant.dart';
import 'package:online_podcast_app_ui/core/app_data.dart';
import 'package:online_podcast_app_ui/core/models/podcast_model.dart';

class PlayerProvider extends ChangeNotifier {
  final String episodeId;
  bool _isPlaying = false;
  bool _isRepeat = false;
  late double _progress;
  late int _totalSeconds;
  Timer? _tick;

  PlayerProvider({required this.episodeId}) {
    final podcast = AppData.podcastById(episodeId);
    final currentLabel =
        podcast.currentTime.isEmpty ? '0:00' : podcast.currentTime;
    final totalLabel = podcast.totalTime.isEmpty ? '23:00' : podcast.totalTime;
    _totalSeconds = _secondsFromLabel(totalLabel);
    final current = _secondsFromLabel(currentLabel);
    _progress = _totalSeconds <= 0
        ? 0
        : (current / _totalSeconds).clamp(0.0, 1.0);
  }

  PodcastModel get podcast => AppData.podcastById(episodeId);

  bool get isPlaying => _isPlaying;

  bool get isRepeat => _isRepeat;

  String get listenedLabel =>
      podcast.listened.isEmpty ? '0 Listened' : podcast.listened;

  String get currentTimeLabel {
    final seconds = (_progress * _totalSeconds).round();
    return _labelFromSeconds(seconds);
  }

  String get totalTimeLabel {
    if (podcast.totalTime.isNotEmpty) return podcast.totalTime;
    return _labelFromSeconds(_totalSeconds);
  }

  double get progress => _progress;

  void togglePlay() {
    _isPlaying = !_isPlaying;
    if (_isPlaying) {
      _startProgressTicks();
    } else {
      _tick?.cancel();
      _tick = null;
    }
    notifyListeners();
  }

  void toggleRepeat() {
    _isRepeat = !_isRepeat;
    notifyListeners();
  }

  void _startProgressTicks() {
    _tick?.cancel();
    _tick = Timer.periodic(
      const Duration(milliseconds: NumberConstant.playerProgressTickMs),
      (_) {
        if (!_isPlaying) return;
        final next = _progress + NumberConstant.playerProgressStep;
        if (next >= 1) {
          if (_isRepeat) {
            _progress = 0;
          } else {
            _progress = 1;
            _isPlaying = false;
            _tick?.cancel();
            _tick = null;
          }
        } else {
          _progress = next;
        }
        notifyListeners();
      },
    );
  }

  int _secondsFromLabel(String label) {
    final parts = label.split(':');
    if (parts.length != 2) return 0;
    final minutes = int.tryParse(parts[0]) ?? 0;
    final seconds = int.tryParse(parts[1]) ?? 0;
    return (minutes * 60) + seconds;
  }

  String _labelFromSeconds(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }
}
