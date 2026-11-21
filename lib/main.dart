import 'package:flutter/material.dart';
import 'package:online_podcast_app_ui/constants/string_const.dart';
import 'package:online_podcast_app_ui/presentation/providers/podcast_library_provider.dart';
import 'package:online_podcast_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PodcastLibraryProvider(),
      child: MaterialApp.router(
        title: StringConst.appTitle,
        theme: ThemeData(
          brightness: .dark,
          fontFamily: StringConst.appFontFamily,
        ),
        routerConfig: router,
        builder: (ctx, child) => child!,
      ),
    );
  }
}
