import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_podcast_app_ui/constants/number_constant.dart';
import 'package:online_podcast_app_ui/constants/string_const.dart';
import 'package:online_podcast_app_ui/core/app_colors.dart';
import 'package:online_podcast_app_ui/core/app_data.dart';
import 'package:online_podcast_app_ui/core/app_textstyles.dart';
import 'package:online_podcast_app_ui/core/asset_res.dart';
import 'package:online_podcast_app_ui/presentation/providers/player_provider.dart';
import 'package:online_podcast_app_ui/presentation/widgets/podcast_tile.dart';
import 'package:online_podcast_app_ui/presentation/widgets/section_header.dart';
import 'package:online_podcast_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlayerProvider>();
    final podcast = provider.podcast;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: .fromLTRB(NumberConstant.horizontalPadding, NumberConstant.headerGap, NumberConstant.horizontalPadding, 0),
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: ListView(
                  padding: .only(bottom: NumberConstant.sectionGap),
                  children: [
                    Column(
                      spacing: NumberConstant.sectionGap,
                      children: [
                        _buildListenedRow(provider.listenedLabel),
                        _buildCover(context, podcast.cover),
                        Text(podcast.author, style: AppTextStyles.playerMeta, textAlign: .center,),
                        Text(podcast.title, style: AppTextStyles.playerTitle, textAlign: .center,),
                        _buildProgress(provider),
                        _buildControls(provider),
                        SectionHeader(title: StringConst.similarTheme,),
                        ...AppData.similarThemePodcasts.map((item) => PodcastTile(
                          podcast: item,
                          onTap: () => context.push(NamedRoutes.nowPlaying.withId(item.id)),
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Padding(
            padding: .all(NumberConstant.navIconPadding),
            child: SvgPicture.asset(AssetRes.icBack, colorFilter: .mode(AppColors.whiteColor, .srcIn),),
          ),
        ),
        Expanded(child: Text(StringConst.nowPlaying, style: AppTextStyles.screenTitle, textAlign: .center,),),
        Padding(
          padding: .all(NumberConstant.navIconPadding),
          child: SvgPicture.asset(AssetRes.icShare, colorFilter: .mode(AppColors.whiteColor, .srcIn),),
        ),
      ],
    );
  }

  Widget _buildListenedRow(String listened) {
    return Row(
      spacing: 6,
      mainAxisAlignment: .center,
      children: [
        SvgPicture.asset(AssetRes.icHeadphones, colorFilter: .mode(AppColors.primaryColor, .srcIn),),
        Text(listened, style: AppTextStyles.playerMeta,),
      ],
    );
  }

  Widget _buildCover(BuildContext context, String cover) {
    final width = MediaQuery.sizeOf(context).width * NumberConstant.playerArtWidthFactor;
    return Center(
      child: SizedBox(
        width: width,
        child: AspectRatio(
          aspectRatio: NumberConstant.playerArtAspectRatio,
          child: ClipRRect(
            borderRadius: .circular(NumberConstant.playerArtRadius),
            child: Image.asset(cover, fit: .cover,),
          ),
        ),
      ),
    );
  }

  Widget _buildProgress(PlayerProvider provider) {
    return Row(
      spacing: NumberConstant.chipGap,
      children: [
        Text(provider.currentTimeLabel, style: AppTextStyles.playerMeta,),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: NumberConstant.progressTrackHeight,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: NumberConstant.progressThumbRadius),
              overlayShape: RoundSliderOverlayShape(overlayRadius: NumberConstant.progressThumbRadius * 2),
              activeTrackColor: AppColors.primaryColor,
              inactiveTrackColor: AppColors.trackColor,
              thumbColor: AppColors.whiteColor,
              disabledActiveTrackColor: AppColors.primaryColor,
              disabledInactiveTrackColor: AppColors.trackColor,
              disabledThumbColor: AppColors.whiteColor,
            ),
            child: Slider(value: provider.progress, onChanged: null,),
          ),
        ),
        Text(provider.totalTimeLabel, style: AppTextStyles.playerMeta,),
      ],
    );
  }

  Widget _buildControls(PlayerProvider provider) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: [
        Padding(
          padding: .all(NumberConstant.playerControlPadding),
          child: SvgPicture.asset(AssetRes.icCut, colorFilter: .mode(AppColors.whiteColor, .srcIn),),
        ),
        Padding(
          padding: .all(NumberConstant.playerControlPadding),
          child: SvgPicture.asset(AssetRes.icPrevious, colorFilter: .mode(AppColors.whiteColor, .srcIn),),
        ),
        GestureDetector(
          onTap: provider.togglePlay,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: .circle,
            ),
            padding: .all(NumberConstant.playButtonPadding),
            child: SvgPicture.asset(provider.isPlaying ? AssetRes.icPause : AssetRes.icPlay, colorFilter: .mode(AppColors.blackColor, .srcIn),),
          ),
        ),
        Padding(
          padding: .all(NumberConstant.playerControlPadding),
          child: SvgPicture.asset(AssetRes.icNext, colorFilter: .mode(AppColors.whiteColor, .srcIn),),
        ),
        GestureDetector(
          onTap: provider.toggleRepeat,
          child: Padding(
            padding: .all(NumberConstant.playerControlPadding),
            child: SvgPicture.asset(AssetRes.icRepeat, colorFilter: .mode(provider.isRepeat ? AppColors.primaryColor : AppColors.whiteColor, .srcIn),),
          ),
        ),
      ],
    );
  }
}
