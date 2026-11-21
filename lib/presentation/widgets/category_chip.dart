import 'package:flutter/material.dart';
import 'package:online_podcast_app_ui/constants/number_constant.dart';
import 'package:online_podcast_app_ui/core/app_colors.dart';
import 'package:online_podcast_app_ui/core/app_textstyles.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.chipIdleColor,
          borderRadius: .circular(NumberConstant.pillRadius),
        ),
        padding: .symmetric(horizontal: NumberConstant.chipPaddingHorizontal, vertical: NumberConstant.chipPaddingVertical),
        child: Text(label, style: isSelected ? AppTextStyles.chip : AppTextStyles.chipIdle,),
      ),
    );
  }
}
