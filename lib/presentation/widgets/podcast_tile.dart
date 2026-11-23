import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_podcast_app_ui/constants/number_constant.dart';
import 'package:online_podcast_app_ui/core/app_colors.dart';
import 'package:online_podcast_app_ui/core/app_textstyles.dart';
import 'package:online_podcast_app_ui/core/asset_res.dart';
import 'package:online_podcast_app_ui/core/models/podcast_model.dart';
import 'package:online_podcast_app_ui/presentation/providers/podcast_library_provider.dart';
import 'package:provider/provider.dart';

class PodcastTile extends StatelessWidget {
  final PodcastModel podcast;
  final VoidCallback? onTap;

  const PodcastTile({
    super.key,
    required this.podcast,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSaved = context.watch<PodcastLibraryProvider>().isSaved(podcast.id);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: .circular(NumberConstant.cardRadius),
        ),
        padding: .all(NumberConstant.tileGap),
        child: Row(
          spacing: NumberConstant.tileGap,
          children: [
            ClipRRect(
              borderRadius: .circular(NumberConstant.coverRadius),
              child: Image.asset(podcast.cover, width: NumberConstant.tileCoverSize, height: NumberConstant.tileCoverSize, fit: .cover,),
            ),
            Expanded(
              child: Column(
                spacing: 6,
                crossAxisAlignment: .start,
                children: [
                  //podcast.title
                  Text(podcast.title, style: AppTextStyles.cardTitle, maxLines: 2, overflow: .ellipsis,),
                  //podcast.author
                  Text(podcast.author, style: AppTextStyles.meta, maxLines: 1, overflow: .ellipsis,),
                  if (podcast.duration.isNotEmpty)
                    Row(
                      spacing: 6,
                      children: [
                        //icClock, mutedColor
                        SvgPicture.asset(AssetRes.icClock, colorFilter: .mode(AppColors.mutedColor, .srcIn),),

                        //podcast.duration, meta
                        Text(podcast.duration, style: AppTextStyles.meta,),
                      ],
                    ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => context.read<PodcastLibraryProvider>().toggleSave(podcast.id),
              child: Container(
                decoration: BoxDecoration(
                  border: .all(color: isSaved ? AppColors.primaryColor : AppColors.mutedColor),
                  borderRadius: .circular(8),
                ),
                padding: .all(NumberConstant.saveIconPadding),
                child: SvgPicture.asset(AssetRes.icSave, colorFilter: .mode(isSaved ? AppColors.primaryColor : AppColors.mutedColor, .srcIn),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
