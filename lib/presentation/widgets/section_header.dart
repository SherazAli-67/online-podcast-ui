import 'package:flutter/material.dart';
import 'package:online_podcast_app_ui/constants/number_constant.dart';
import 'package:online_podcast_app_ui/constants/string_const.dart';
import 'package:online_podcast_app_ui/core/app_colors.dart';
import 'package:online_podcast_app_ui/core/app_textstyles.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeMore;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeMore,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: AppTextStyles.sectionTitle,),),
        GestureDetector(
          onTap: onSeeMore,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.seeMoreColor,
              borderRadius: .circular(NumberConstant.pillRadius),
            ),
            padding: .symmetric(horizontal: NumberConstant.chipPaddingHorizontal, vertical: NumberConstant.chipPaddingVertical),
            child: Text(StringConst.seeMore, style: AppTextStyles.seeMore,),
          ),
        ),
      ],
    );
  }
}
