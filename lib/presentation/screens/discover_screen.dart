import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:online_podcast_app_ui/constants/number_constant.dart';
import 'package:online_podcast_app_ui/constants/string_const.dart';
import 'package:online_podcast_app_ui/core/app_colors.dart';
import 'package:online_podcast_app_ui/core/app_data.dart';
import 'package:online_podcast_app_ui/core/app_textstyles.dart';
import 'package:online_podcast_app_ui/core/asset_res.dart';
import 'package:online_podcast_app_ui/core/models/podcast_model.dart';
import 'package:online_podcast_app_ui/presentation/providers/discover_provider.dart';
import 'package:online_podcast_app_ui/presentation/widgets/category_chip.dart';
import 'package:online_podcast_app_ui/presentation/widgets/podcast_tile.dart';
import 'package:online_podcast_app_ui/presentation/widgets/section_header.dart';
import 'package:online_podcast_app_ui/routing/router.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DiscoverProvider>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: .fromLTRB(NumberConstant.horizontalPadding, NumberConstant.headerGap, NumberConstant.horizontalPadding, 0),
          child: Column(
            spacing: NumberConstant.headerGap,
            children: [
              _buildHeader(context),
              _buildSearchRow(provider),
              _buildCategories(provider),
              Expanded(child: _buildContent(context, provider),),
              _buildBottomNav(context),
              _buildHomeIndicator(),
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
          onTap: () => context.go(NamedRoutes.welcome.routeName),
          child: Padding(
            padding: .all(NumberConstant.navIconPadding),
            //icBack
            child: const SizedBox()
          ),
        ),
        //StringConst.discover
        Expanded(child: Text('', style: AppTextStyles.screenTitle, textAlign: .center,),),
        Padding(
          padding: .all(NumberConstant.navIconPadding),
          //icMore, whiteColor
          child: const SizedBox(),
        ),
      ],
    );
  }

  Widget _buildSearchRow(DiscoverProvider provider) {
    return Row(
      spacing: NumberConstant.chipGap,
      children: [
        Expanded(
          child: TextField(
            onChanged: provider.updateSearch,
            style: AppTextStyles.searchHint.copyWith(color: AppColors.titleColor),
            cursorColor: AppColors.primaryColor,
            decoration: InputDecoration(
              //StringConst.searchTopics
              hintText: '',
              hintStyle: AppTextStyles.searchHint,
              filled: true,
              //searchFillColor
              fillColor: Colors.transparent,
              border: OutlineInputBorder(borderRadius: .circular(NumberConstant.searchRadius), borderSide: .none,),
              enabledBorder: OutlineInputBorder(borderRadius: .circular(NumberConstant.searchRadius), borderSide: .none,),
              focusedBorder: OutlineInputBorder(borderRadius: .circular(NumberConstant.searchRadius), borderSide: .none,),
              contentPadding: .symmetric(horizontal: NumberConstant.searchFieldPadding, vertical: NumberConstant.searchFieldPadding),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            //primaryColor
            color: Colors.transparent,
            borderRadius: .circular(NumberConstant.searchRadius),
          ),
          padding: .all(NumberConstant.searchButtonPadding),
          //icSearch
          child: const SizedBox()
        ),
      ],
    );
  }

  Widget _buildCategories(DiscoverProvider provider) {
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Row(
        spacing: NumberConstant.chipGap,
        children: AppData.discoverCategories.map((category) => CategoryChip(
          label: category,
          isSelected: provider.selectedCategory == category,
          onTap: () => provider.selectCategory(category),),
        ).toList(),
      ),
    );
  }

  Widget _buildContent(BuildContext context, DiscoverProvider provider) {
    return ListView(
      padding: .only(bottom: NumberConstant.headerGap),
      children: [
        Column(
          spacing: NumberConstant.listGap,
          crossAxisAlignment: .start,
          children: [
            // SectionHeader(title: StringConst.popular,),
            _buildPopularList(context, provider.popularPodcasts),
            // SectionHeader(title: StringConst.writing,),
            ...provider.writingPodcasts.map((podcast) => PodcastTile(
              podcast: podcast,
              onTap: () => context.push(NamedRoutes.nowPlaying.withId(podcast.id)),
            ),),
          ],
        ),
      ],
    );
  }

  Widget _buildPopularList(BuildContext context, List<PodcastModel> podcasts) {
    final cardWidth = MediaQuery.sizeOf(context).width * NumberConstant.popularCardWidthFactor;
    return SizedBox(
      height: cardWidth / NumberConstant.popularCoverAspectRatio + 88,
      child: ListView.separated(
        scrollDirection: .horizontal,
        itemCount: podcasts.length,
        separatorBuilder: (_, _) => const SizedBox(width: NumberConstant.popularCardGap),
        itemBuilder: (_, index) => _buildPopularCard(context, podcasts[index], cardWidth),
      ),
    );
  }

  Widget _buildPopularCard(BuildContext context, PodcastModel podcast, double width) {
    return GestureDetector(
      onTap: () => context.push(NamedRoutes.nowPlaying.withId(podcast.id)),
      child: SizedBox(
        width: width,
        child: Column(
          spacing: 8,
          crossAxisAlignment: .start,
          children: [
            AspectRatio(
              aspectRatio: NumberConstant.popularCoverAspectRatio,
              child: ClipRRect(
                borderRadius: .circular(NumberConstant.coverRadius),
                //podcast.cover
                child: const SizedBox(),
              ),
            ),
            Row(
              spacing: 6,
              children: [
                // SvgPicture.asset(AssetRes.icHeadphones, colorFilter: .mode(AppColors.primaryColor, .srcIn),),
                //podcast.listened, meta
                Expanded(child: const SizedBox()),
              ],
            ),
            //podcast.title, cardTitle,
            Text('', style: AppTextStyles.cardTitle, maxLines: 1, overflow: .ellipsis,),
            //podcast.author
            Text('', style: AppTextStyles.meta, maxLines: 1, overflow: .ellipsis,),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Padding(
      padding: .only(top: NumberConstant.bottomNavTopGap),
      child: Row(
        mainAxisAlignment: .spaceEvenly,
        children: [
          GestureDetector(
            onTap: () => context.go(NamedRoutes.welcome.routeName),
            child: Padding(
              padding: .all(NumberConstant.navIconPadding),
              child: SvgPicture.asset(AssetRes.icHome, colorFilter: .mode(AppColors.whiteColor, .srcIn),),
            ),
          ),
          Padding(
            padding: .all(NumberConstant.navIconPadding),
            child: SvgPicture.asset(AssetRes.icDiscover),
          ),
          Padding(
            padding: .all(NumberConstant.navIconPadding),
            child: SvgPicture.asset(AssetRes.icBookmarkNav, colorFilter: .mode(AppColors.whiteColor, .srcIn),),
          ),
          GestureDetector(
            onTap: () => context.push(NamedRoutes.profile.routeName),
            child: Padding(
              padding: .all(NumberConstant.navIconPadding),
              child: SvgPicture.asset(AssetRes.icUser, colorFilter: .mode(AppColors.whiteColor, .srcIn),),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeIndicator() {
    return Padding(
      padding: .only(bottom: NumberConstant.headerGap),
      child: FractionallySizedBox(
        widthFactor: NumberConstant.indicatorWidthFactor,
        child: Container(
          height: NumberConstant.indicatorHeight,
          decoration: BoxDecoration(
            color: AppColors.indicatorColor,
            borderRadius: .circular(NumberConstant.pillRadius),
          ),
        ),
      ),
    );
  }
}
