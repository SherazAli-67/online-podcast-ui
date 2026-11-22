import 'package:flutter/material.dart';
import 'package:online_podcast_app_ui/constants/string_const.dart';
import 'package:online_podcast_app_ui/core/app_colors.dart';

class AppTextStyles {
  static const welcomeTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 32,
    height: 1.3,
    letterSpacing: 1.2,
    color: AppColors.whiteColor,
  );

  static const welcomeSubtitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 18,
    height: 1.5,
    letterSpacing: 0.5,
    color: AppColors.bodyColor,
  );

  static const button = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w600,
    fontSize: 16,
    height: 1.4,
    letterSpacing: 0.6,
    color: AppColors.whiteColor,
  );

  static const screenTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w600,
    fontSize: 20,
    height: 1.3,
    letterSpacing: 0.4,
    color: AppColors.titleColor,
  );

  static const sectionTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w600,
    fontSize: 18,
    height: 1.3,
    color: AppColors.titleColor,
  );

  static const cardTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w600,
    fontSize: 14,
    height: 1.36,
    letterSpacing: 0.4,
    color: AppColors.cardTitleColor,
  );

  static const meta = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 12,
    height: 1.5,
    letterSpacing: 0.3,
    color: AppColors.mutedColor,
  );

  static const chip = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w600,
    fontSize: 14,
    height: 1.4,
    letterSpacing: 0.3,
    color: AppColors.backgroundColor,
  );

  static const chipIdle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 14,
    height: 1.4,
    letterSpacing: 0.3,
    color: AppColors.hintColor,
  );

  static const chipSubtle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w600,
    fontSize: 14,
    height: 1.4,
    letterSpacing: 0.3,
    color: AppColors.subtleColor,
  );


  static const searchHint = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 15,
    height: 1.4,
    letterSpacing: 0.4,
    color: AppColors.hintColor,
  );

  static const seeMore = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 13,
    height: 1.3,
    letterSpacing: 0.3,
    color: AppColors.hintColor,
  );

  static const statValue = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w600,
    fontSize: 16,
    height: 1.4,
    color: AppColors.titleColor,
  );

  static const profileName = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w600,
    fontSize: 18,
    height: 1.4,
    letterSpacing: 0.6,
    color: AppColors.titleColor,
  );

  static const playerTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w600,
    fontSize: 20,
    height: 1.5,
    letterSpacing: 0.6,
    color: AppColors.titleColor,
  );

  static const playerMeta = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 14,
    height: 1.5,
    letterSpacing: 0.4,
    color: AppColors.mutedColor,
  );
}

