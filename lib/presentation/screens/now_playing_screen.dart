import 'package:flutter/material.dart';
import 'package:online_podcast_app_ui/constants/string_const.dart';
import 'package:online_podcast_app_ui/core/app_colors.dart';
import 'package:online_podcast_app_ui/core/app_textstyles.dart';

class NowPlayingScreen extends StatelessWidget {
  final String episodeId;

  const NowPlayingScreen({super.key, required this.episodeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(child: Text(StringConst.nowPlaying, style: AppTextStyles.screenTitle,),),
    );
  }
}
