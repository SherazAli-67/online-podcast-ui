import 'package:flutter/material.dart';
import 'package:online_podcast_app_ui/constants/string_const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: StringConst.appTitle,
      theme: ThemeData(
        brightness: .dark
      ),
      home: Scaffold(body: Text("Online Podcast"),)
    );
  }
}