import 'package:flutter/material.dart';
import 'package:online_podcast_app_ui/constants/string_const.dart';
import 'package:online_podcast_app_ui/core/app_data.dart';
import 'package:online_podcast_app_ui/core/models/podcast_model.dart';

class ProfileProvider extends ChangeNotifier {
  String _selectedTab = StringConst.newest;
  bool _isFollowing = false;

  String get selectedTab => _selectedTab;

  bool get isFollowing => _isFollowing;

  List<PodcastModel> get podcasts => AppData.profilePodcastsByTab(_selectedTab);

  void selectTab(String tab) {
    _selectedTab = tab;
    notifyListeners();
  }

  void toggleFollow() {
    _isFollowing = !_isFollowing;
    notifyListeners();
  }
}
