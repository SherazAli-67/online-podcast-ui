import 'package:flutter/material.dart';
import 'package:online_podcast_app_ui/constants/string_const.dart';
import 'package:online_podcast_app_ui/core/app_data.dart';
import 'package:online_podcast_app_ui/core/models/podcast_model.dart';

class DiscoverProvider extends ChangeNotifier {
  String _searchQuery = '';
  String _selectedCategory = StringConst.all;

  String get searchQuery => _searchQuery;

  String get selectedCategory => _selectedCategory;

  void updateSearch(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  List<PodcastModel> get popularPodcasts => _filter(AppData.popularPodcasts);

  List<PodcastModel> get writingPodcasts => _filter(AppData.writingPodcasts);

  List<PodcastModel> _filter(List<PodcastModel> podcasts) {
    final query = _searchQuery.trim().toLowerCase();
    return podcasts.where((podcast) {
      final matchesCategory = _selectedCategory == StringConst.all || podcast.category == _selectedCategory;
      final matchesSearch = query.isEmpty || podcast.title.toLowerCase().contains(query) || podcast.author.toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }
}
