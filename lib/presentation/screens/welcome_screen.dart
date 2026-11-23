import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_podcast_app_ui/constants/number_constant.dart';
import 'package:online_podcast_app_ui/constants/string_const.dart';
import 'package:online_podcast_app_ui/core/app_colors.dart';
import 'package:online_podcast_app_ui/core/app_textstyles.dart';
import 'package:online_podcast_app_ui/core/asset_res.dart';
import 'package:online_podcast_app_ui/routing/router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Column(
              children: [
                Expanded(flex: NumberConstant.welcomeHeroFlex, child: _buildHeroSection(),),
                Expanded(flex: NumberConstant.welcomeContentFlex, child: _buildContentSection(context),),
              ],
            ),
            Positioned(
              top: constraints.maxHeight * NumberConstant.welcomeMicTopFactor,
              right: constraints.maxWidth * NumberConstant.welcomeMicRightFactor,
              child: SizedBox(
                width: constraints.maxWidth * NumberConstant.welcomeMicWidthFactor,
                child: Transform.rotate(
                  angle: 4.39 * math.pi / 180,
                  //micImg, fit.contain
                  child: const SizedBox()
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Stack(
      fit: .expand,
      children: [
        //welcomeImg, width.infinity, fit.cover
        Align(
          alignment: .bottomCenter,
          child: Container(
            height: NumberConstant.welcomeGradientHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: .topCenter,
                end: .bottomCenter,
                colors: [
                  // AppColors.backgroundColor.withValues(alpha: 0),
                  // AppColors.backgroundColor,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Padding(
      padding: .fromLTRB(NumberConstant.horizontalPadding, NumberConstant.headerGap, NumberConstant.horizontalPadding, NumberConstant.sectionGap),
      child: Column(
        spacing: NumberConstant.sectionGap,
        mainAxisAlignment: .center,
        children: [
          //learnNewThings, welcomeTitle, textAlign.center
          //welcomeSubtitle, welcomeSubtitle, textAlign.center
          // _buildGetStartedButton(context),
        ],
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(NamedRoutes.discover.routeName),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: .circular(NumberConstant.pillRadius),
        ),
        padding: .symmetric(horizontal: NumberConstant.buttonPaddingHorizontal, vertical: NumberConstant.buttonPaddingVertical),
        child: Text(StringConst.getStarted, style: AppTextStyles.button,),
      ),
    );
  }
}
