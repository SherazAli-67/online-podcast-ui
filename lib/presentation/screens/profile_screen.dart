import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_podcast_app_ui/constants/number_constant.dart';
import 'package:online_podcast_app_ui/constants/string_const.dart';
import 'package:online_podcast_app_ui/core/app_colors.dart';
import 'package:online_podcast_app_ui/core/app_data.dart';
import 'package:online_podcast_app_ui/core/app_textstyles.dart';
import 'package:online_podcast_app_ui/core/asset_res.dart';
import 'package:online_podcast_app_ui/presentation/providers/profile_provider.dart';
import 'package:online_podcast_app_ui/presentation/widgets/animated_entrance.dart';
import 'package:online_podcast_app_ui/presentation/widgets/category_chip.dart';
import 'package:online_podcast_app_ui/presentation/widgets/podcast_tile.dart';
import 'package:online_podcast_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Duration _staggerDelay(int index) {
    final capped = index.clamp(0, NumberConstant.animListStaggerCap);
    return Duration(milliseconds: capped * NumberConstant.animListStaggerMs);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    final profile = AppData.profile;
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
            spacing: NumberConstant.headerGap,
            children: [
              FadeSlideIn(child: _buildHeader(context)),
              FadeSlideIn(
                delay: const Duration(milliseconds: NumberConstant.animStaggerMs),
                child: _buildProfileInfo(
                  context,
                  profile.name,
                  profile.role,
                  profile.avatar,
                ),
              ),
              FadeSlideIn(
                delay: const Duration(
                  milliseconds: NumberConstant.animStaggerMs * 2,
                ),
                child: _buildStats(
                  profile.podcastCount,
                  profile.followers,
                  profile.shares,
                ),
              ),
              FadeSlideIn(
                delay: const Duration(
                  milliseconds: NumberConstant.animStaggerMs * 3,
                ),
                child: _buildFollowButton(provider),
              ),
              FadeSlideIn(
                delay: const Duration(
                  milliseconds: NumberConstant.animStaggerMs * 4,
                ),
                child: _buildTabs(provider),
              ),
              Expanded(child: _buildPodcastList(context, provider)),
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
            StringConst.profile,
            style: AppTextStyles.screenTitle,
            textAlign: .center,
          ),
        ),
        Padding(
          padding: .all(NumberConstant.navIconPadding),
          child: SvgPicture.asset(
            AssetRes.icMore,
            colorFilter: .mode(AppColors.whiteColor, .srcIn),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo(
    BuildContext context,
    String name,
    String role,
    String avatar,
  ) {
    final avatarSize =
        MediaQuery.sizeOf(context).width * NumberConstant.avatarWidthFactor;
    return Column(
      spacing: NumberConstant.profileInfoGap,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: .circle,
            border: .all(
              color: AppColors.primaryColor,
              width: NumberConstant.avatarBorderWidth,
            ),
          ),
          padding: .all(NumberConstant.avatarBorderWidth),
          child: ClipOval(
            child: Image.asset(
              avatar,
              width: avatarSize,
              height: avatarSize,
              fit: .cover,
            ),
          ),
        ),
        Text(name, style: AppTextStyles.profileName, textAlign: .center),
        Text(role, style: AppTextStyles.meta, textAlign: .center),
      ],
    );
  }

  Widget _buildStats(String podcastCount, String followers, String shares) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: [
        _buildStatItem(podcastCount, StringConst.podcast),
        _buildStatItem(followers, StringConst.followers),
        _buildStatItem(shares, StringConst.share),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      spacing: 4,
      children: [
        Text(value, style: AppTextStyles.statValue),
        Text(label, style: AppTextStyles.meta),
      ],
    );
  }

  Widget _buildFollowButton(ProfileProvider provider) {
    return PressScale(
      onTap: provider.toggleFollow,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: NumberConstant.animFastMs),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: provider.isFollowing
              ? AppColors.chipSurfaceColor
              : AppColors.primaryColor,
          borderRadius: .circular(NumberConstant.pillRadius),
        ),
        padding: .symmetric(
          horizontal: NumberConstant.followPaddingHorizontal,
          vertical: NumberConstant.followPaddingVertical,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: NumberConstant.animFastMs),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: animation, child: child),
          ),
          child: Text(
            provider.isFollowing ? StringConst.following : StringConst.follow,
            key: ValueKey(provider.isFollowing),
            style: AppTextStyles.button,
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(ProfileProvider provider) {
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Row(
        spacing: NumberConstant.chipGap,
        children: AppData.profileTabs
            .map(
              (tab) => CategoryChip(
                label: tab,
                isSelected: provider.selectedTab == tab,
                idleColor: AppColors.chipSurfaceColor,
                idleTextStyle: AppTextStyles.chipSubtle,
                onTap: () => provider.selectTab(tab),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPodcastList(BuildContext context, ProfileProvider provider) {
    final podcasts = provider.podcasts;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: NumberConstant.animNormalMs),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: podcasts.isEmpty
          ? const SizedBox.shrink(key: ValueKey('empty'))
          : ListView.separated(
              key: ValueKey(provider.selectedTab),
              padding: .only(bottom: NumberConstant.sectionGap),
              itemCount: podcasts.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: NumberConstant.listGap),
              itemBuilder: (_, index) {
                final podcast = podcasts[index];
                return FadeSlideIn(
                  delay: _staggerDelay(index),
                  child: PodcastTile(
                    podcast: podcast,
                    heroTag: podcastCoverHeroTag(podcast.id),
                    onTap: () => context.push(
                      NamedRoutes.nowPlaying.withId(podcast.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
