import 'package:go_router/go_router.dart';
import 'package:online_podcast_app_ui/presentation/providers/discover_provider.dart';
import 'package:online_podcast_app_ui/presentation/screens/discover_screen.dart';
import 'package:online_podcast_app_ui/presentation/screens/now_playing_screen.dart';
import 'package:online_podcast_app_ui/presentation/screens/profile_screen.dart';
import 'package:online_podcast_app_ui/presentation/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.welcome.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (_, state) => const WelcomeScreen()),
    GoRoute(
      path: NamedRoutes.discover.routeName,
      builder: (_, state) => ChangeNotifierProvider(create: (_) => DiscoverProvider(), child: const DiscoverScreen(),),
    ),
    GoRoute(
      path: NamedRoutes.nowPlaying.routeName,
      builder: (_, state) => NowPlayingScreen(episodeId: state.pathParameters['id'] ?? '',),
    ),
    GoRoute(path: NamedRoutes.profile.routeName, builder: (_, state) => const ProfileScreen()),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  discover('/discover'),
  nowPlaying('/now-playing/:id'),
  profile('/profile');

  final String routeName;
  const NamedRoutes(this.routeName);

  String withId(String id) => routeName.replaceFirst(':id', id);
}
