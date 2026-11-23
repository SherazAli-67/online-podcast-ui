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
import 'package:online_podcast_app_ui/presentation/widgets/animated_entrance.dart';
import 'package:online_podcast_app_ui/presentation/widgets/podcast_tile.dart';
import 'package:online_podcast_app_ui/presentation/widgets/section_header.dart';
import 'package:online_podcast_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  Duration _staggerDelay(int index) {
    final capped = index.clamp(0, NumberConstant.animListStaggerCap);
    return Duration(milliseconds: capped * NumberConstant.animListStaggerMs);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlayerProvider>();
    final podcast = provider.podcast;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: .fromLTRB(
            NumberConstant.horizontalPadding,
            NumberConstant.headerGap,
            NumberConstant.horizontalPadding,
            0,
          ),
          child: Column(
            children: [
              FadeSlideIn(child: _buildHeader(context)),
              Expanded(
                child: ListView(
                  padding: .only(bottom: NumberConstant.sectionGap),
                  children: [
                    Column(
                      spacing: NumberConstant.sectionGap,
                      children: [
                        FadeSlideIn(
                          delay: const Duration(milliseconds: NumberConstant.animStaggerMs,),
                          child: _buildListenedRow(provider.listenedLabel),
                        ),
                        FadeSlideIn(
                          delay: const Duration(
                            milliseconds: NumberConstant.animStaggerMs,
                          ),
                          child: _PulsingCover(
                            cover: podcast.cover,
                            heroTag: podcastCoverHeroTag(podcast.id),
                            isPlaying: provider.isPlaying,
                          ),
                        ),
                        FadeSlideIn(
                          delay: const Duration(
                            milliseconds: NumberConstant.animStaggerMs * 2,
                          ),
                          child: Text(
                            podcast.author,
                            style: AppTextStyles.playerMeta,
                            textAlign: .center,
                          ),
                        ),
                        FadeSlideIn(
                          delay: const Duration(
                            milliseconds: NumberConstant.animStaggerMs * 2,
                          ),
                          child: Text(
                            podcast.title,
                            style: AppTextStyles.playerTitle,
                            textAlign: .center,
                          ),
                        ),
                        FadeSlideIn(
                          delay: const Duration(
                            milliseconds: NumberConstant.animStaggerMs * 3,
                          ),
                          child: _buildProgress(provider),
                        ),
                        FadeSlideIn(
                          delay: const Duration(
                            milliseconds: NumberConstant.animStaggerMs * 3,
                          ),
                          child: _buildControls(provider),
                        ),
                        FadeSlideIn(
                          delay: const Duration(
                            milliseconds: NumberConstant.animStaggerMs * 4,
                          ),
                          child: const SectionHeader(
                            title: StringConst.similarTheme,
                          ),
                        ),
                        ...AppData.similarThemePodcasts.asMap().entries.map(
                          (entry) => FadeSlideIn(
                            delay: _staggerDelay(entry.key + 4),
                            child: PodcastTile(
                              podcast: entry.value,
                              onTap: () => context.push(
                                NamedRoutes.nowPlaying.withId(entry.value.id),
                              ),
                            ),
                          ),
                        ),
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
            child: SvgPicture.asset(
              AssetRes.icBack,
              colorFilter: .mode(AppColors.whiteColor, .srcIn),
            ),
          ),
        ),
        Expanded(
          child: Text(
            StringConst.nowPlaying,
            style: AppTextStyles.screenTitle,
            textAlign: .center,
          ),
        ),
        Padding(
          padding: .all(NumberConstant.navIconPadding),
          child: SvgPicture.asset(
            AssetRes.icShare,
            colorFilter: .mode(AppColors.whiteColor, .srcIn),
          ),
        ),
      ],
    );
  }

  Widget _buildListenedRow(String listened) {
    return Row(
      spacing: 6,
      mainAxisAlignment: .center,
      children: [
        SvgPicture.asset(
          AssetRes.icHeadphones,
          colorFilter: .mode(AppColors.primaryColor, .srcIn),
        ),
        Text(listened, style: AppTextStyles.playerMeta),
      ],
    );
  }

  Widget _buildProgress(PlayerProvider provider) {
    return Row(
      spacing: NumberConstant.chipGap,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: NumberConstant.animFastMs),
          child: Text(
            provider.currentTimeLabel,
            key: ValueKey(provider.currentTimeLabel),
            style: AppTextStyles.playerMeta,
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              trackHeight: NumberConstant.progressTrackHeight,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: NumberConstant.progressThumbRadius,
              ),
              overlayShape: RoundSliderOverlayShape(
                overlayRadius: NumberConstant.progressThumbRadius * 2,
              ),
              activeTrackColor: AppColors.primaryColor,
              inactiveTrackColor: AppColors.trackColor,
              thumbColor: AppColors.whiteColor,
              disabledActiveTrackColor: AppColors.primaryColor,
              disabledInactiveTrackColor: AppColors.trackColor,
              disabledThumbColor: AppColors.whiteColor,
            ),
            child: Slider(value: provider.progress, onChanged: null),
          ),
        ),
        Text(provider.totalTimeLabel, style: AppTextStyles.playerMeta),
      ],
    );
  }

  Widget _buildControls(PlayerProvider provider) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: [
        Padding(
          padding: .all(NumberConstant.playerControlPadding),
          child: SvgPicture.asset(
            AssetRes.icCut,
            colorFilter: .mode(AppColors.whiteColor, .srcIn),
          ),
        ),
        Padding(
          padding: .all(NumberConstant.playerControlPadding),
          child: SvgPicture.asset(
            AssetRes.icPrevious,
            colorFilter: .mode(AppColors.whiteColor, .srcIn),
          ),
        ),
        _PlayPauseButton(
          isPlaying: provider.isPlaying,
          onTap: provider.togglePlay,
        ),
        Padding(
          padding: .all(NumberConstant.playerControlPadding),
          child: SvgPicture.asset(
            AssetRes.icNext,
            colorFilter: .mode(AppColors.whiteColor, .srcIn),
          ),
        ),
        GestureDetector(
          onTap: provider.toggleRepeat,
          child: Padding(
            padding: .all(NumberConstant.playerControlPadding),
            child: AnimatedScale(
              scale: provider.isRepeat ? 1.1 : 1,
              duration: const Duration(milliseconds: NumberConstant.animFastMs),
              curve: Curves.easeOutBack,
              child: SvgPicture.asset(
                AssetRes.icRepeat,
                colorFilter: .mode(
                  provider.isRepeat
                      ? AppColors.primaryColor
                      : AppColors.whiteColor,
                  .srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PulsingCover extends StatefulWidget {
  const _PulsingCover({
    required this.cover,
    required this.heroTag,
    required this.isPlaying,
  });

  final String cover;
  final String heroTag;
  final bool isPlaying;

  @override
  State<_PulsingCover> createState() => _PulsingCoverState();
}

class _PulsingCoverState extends State<_PulsingCover> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: NumberConstant.playerCoverPulseMs),
    );
    _scale = Tween<double>(
      begin: 1,
      end: NumberConstant.playerCoverPulseScale,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncPulse());
  }

  @override
  void didUpdateWidget(covariant _PulsingCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isPlaying != widget.isPlaying) {
      _syncPulse();
    }
  }

  void _syncPulse() {
    if (!mounted) return;
    if (MediaQuery.disableAnimationsOf(context) || !widget.isPlaying) {
      _controller.stop();
      _controller.value = 0;
      return;
    }
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.sizeOf(context).width * NumberConstant.playerArtWidthFactor;
    return Center(
      child: SizedBox(
        width: width,
        child: AspectRatio(
          aspectRatio: NumberConstant.playerArtAspectRatio,
          child: AnimatedBuilder(
            animation: _scale,
            builder: (context, child) => Transform.scale(
              scale: _scale.value,
              child: child,
            ),
            child: Hero(
              tag: widget.heroTag,
              child: ClipRRect(
                borderRadius: .circular(NumberConstant.playerArtRadius),
                child: Image.asset(widget.cover, fit: .cover),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayPauseButton extends StatefulWidget {
  const _PlayPauseButton({
    required this.isPlaying,
    required this.onTap,
  });

  final bool isPlaying;
  final VoidCallback onTap;

  @override
  State<_PlayPauseButton> createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<_PlayPauseButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapCancel: () => _setPressed(false),
      onTapUp: (_) => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? NumberConstant.playButtonBounceScale : 1,
        duration: const Duration(milliseconds: NumberConstant.animFastMs),
        curve: Curves.easeOutCubic,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            shape: .circle,
          ),
          padding: .all(NumberConstant.playButtonPadding),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: NumberConstant.animFastMs),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: SvgPicture.asset(
              widget.isPlaying ? AssetRes.icPause : AssetRes.icPlay,
              key: ValueKey(widget.isPlaying),
              colorFilter: .mode(AppColors.blackColor, .srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
