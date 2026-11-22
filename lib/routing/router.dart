import 'package:go_router/go_router.dart';
import 'package:online_podcast_app_ui/presentation/screens/discover_screen.dart';
import 'package:online_podcast_app_ui/presentation/screens/welcome_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.welcome.routeName,
  routes: [
    GoRoute(path: NamedRoutes.welcome.routeName, builder: (_, state) => const WelcomeScreen()),
    GoRoute(path: NamedRoutes.discover.routeName, builder: (_, state) => const DiscoverScreen()),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  discover('/discover');

  final String routeName;
  const NamedRoutes(this.routeName);
}
