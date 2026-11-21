import 'package:flutter/material.dart';

class PodcastLibraryProvider extends ChangeNotifier {
  final Set<String> _savedIds = {};

  bool isSaved(String id) => _savedIds.contains(id);

  void toggleSave(String id) {
    if (_savedIds.contains(id)) {
      _savedIds.remove(id);
    } else {
      _savedIds.add(id);
    }
    notifyListeners();
  }
}
