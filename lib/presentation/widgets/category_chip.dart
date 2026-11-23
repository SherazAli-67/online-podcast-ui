import 'package:flutter/material.dart';
import 'package:online_podcast_app_ui/constants/number_constant.dart';
import 'package:online_podcast_app_ui/core/app_colors.dart';
import 'package:online_podcast_app_ui/core/app_textstyles.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? idleColor;
  final TextStyle? idleTextStyle;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.idleColor,
    this.idleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: isSelected ? NumberConstant.chipSelectedScale : 1,
        duration: const Duration(milliseconds: NumberConstant.animFastMs),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: NumberConstant.animFastMs),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryColor
                : (idleColor ?? AppColors.chipIdleColor),
            borderRadius: .circular(NumberConstant.pillRadius),
          ),
          padding: .symmetric(
            horizontal: NumberConstant.chipPaddingHorizontal,
            vertical: NumberConstant.chipPaddingVertical,
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: NumberConstant.animFastMs),
            curve: Curves.easeInOut,
            style: isSelected
                ? AppTextStyles.chip
                : (idleTextStyle ?? AppTextStyles.chipIdle),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
