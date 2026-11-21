import 'package:online_podcast_app_ui/constants/string_const.dart';
import 'package:online_podcast_app_ui/core/asset_res.dart';
import 'package:online_podcast_app_ui/core/models/podcast_model.dart';
import 'package:online_podcast_app_ui/core/models/profile_model.dart';

class AppData {
  static const discoverCategories = [
    StringConst.all,
    StringConst.popular,
    StringConst.writing,
    StringConst.cooking,
  ];

  static const profileTabs = [
    StringConst.newest,
    StringConst.popular,
    StringConst.comments,
  ];

  static const profile = ProfileModel(
    name: 'Muthu Krishnan',
    role: 'Product Designer',
    avatar: AssetRes.profileAvatar,
    podcastCount: '167',
    followers: '5001',
    shares: '350',
  );

  static const popularPodcasts = [
    PodcastModel(
      id: 'who-weekly',
      title: '“Who? Weekly. The world of Whos has never been...',
      author: 'Lindsey Weber',
      cover: AssetRes.whoWeeklyCover,
      category: StringConst.popular,
      listened: '32,22,100 Listened',
    ),
    PodcastModel(
      id: 'midnight-miracle',
      title: 'The Midnight Miracle',
      author: 'Dave Chappelle',
      cover: AssetRes.midnightMiracleCover,
      category: StringConst.popular,
      listened: '4,61,720 Listened',
    ),
  ];

  static const writingPodcasts = [
    PodcastModel(
      id: 'heavyweight',
      title: 'Heavyweight - The complete journey',
      author: 'Jonathan Goldstein',
      cover: AssetRes.heavyweightCover,
      category: StringConst.writing,
      duration: '53 Minutes',
    ),
  ];

  static const nowPlayingPodcast = PodcastModel(
    id: 'best-podcasts-2022',
    title: 'The Best Podcasts of 2022',
    author: 'vulture',
    cover: AssetRes.bestPodcastsCover,
    category: StringConst.popular,
    listened: '5,22,100 Listened',
    currentTime: '16:00',
    totalTime: '23:00',
    duration: '23 Minutes',
  );

  static const similarThemePodcasts = [
    PodcastModel(
      id: 'ux-juniors',
      title: 'UX Design: Most Juniors FAIL At This!',
      author: 'AJ&Smart',
      cover: AssetRes.uxJuniorsCover,
      category: StringConst.popular,
      duration: '23 Minutes',
    ),
  ];

  static const profilePodcasts = [
    PodcastModel(
      id: 'ux-juniors-profile',
      title: 'UX Design: Most Juniors FAIL At This!',
      author: 'Muthu Krishnan',
      cover: AssetRes.uxJuniorsCover,
      category: StringConst.popular,
      duration: '23 Minutes',
      profileTab: StringConst.newest,
    ),
    PodcastModel(
      id: 'ux-overview',
      title: 'What Is UX Design? A Full Overview',
      author: 'Muthu Krishnan',
      cover: AssetRes.uxOverviewCover,
      category: StringConst.popular,
      duration: '15 Minutes',
      profileTab: StringConst.newest,
    ),
    PodcastModel(
      id: 'study-research',
      title: 'Study research in UX Designer',
      author: 'Design Course',
      cover: AssetRes.studyResearchCover,
      category: StringConst.popular,
      duration: '12 Minutes',
      profileTab: StringConst.popular,
    ),
  ];

  static const allPodcasts = [
    ...popularPodcasts,
    ...writingPodcasts,
    nowPlayingPodcast,
    ...similarThemePodcasts,
    ...profilePodcasts,
  ];

  static PodcastModel podcastById(String id) => allPodcasts.firstWhere((podcast) => podcast.id == id, orElse: () => nowPlayingPodcast,);

  static List<PodcastModel> profilePodcastsByTab(String tab) => profilePodcasts.where((podcast) => podcast.profileTab == tab).toList();
}
