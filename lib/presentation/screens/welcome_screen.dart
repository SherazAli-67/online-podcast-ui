import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:online_podcast_app_ui/constants/number_constant.dart';
import 'package:online_podcast_app_ui/constants/string_const.dart';
import 'package:online_podcast_app_ui/core/app_colors.dart';
import 'package:online_podcast_app_ui/core/app_textstyles.dart';
import 'package:online_podcast_app_ui/core/asset_res.dart';
import 'package:online_podcast_app_ui/presentation/widgets/animated_entrance.dart';
import 'package:online_podcast_app_ui/routing/router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const _titleDelay = Duration(milliseconds: NumberConstant.animStaggerMs);
  static const _subtitleDelay = Duration(milliseconds: NumberConstant.animStaggerMs * 2);
  static const _ctaDelay = Duration(milliseconds: NumberConstant.animStaggerMs * 3);
  static const _micDelay = Duration(milliseconds: NumberConstant.animStaggerMs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: NumberConstant.welcomeHeroFlex,
                  child: FadeSlideIn(child: _buildHeroSection()),
                ),
                Expanded(
                  flex: NumberConstant.welcomeContentFlex,
                  child: _buildContentSection(context),
                ),
              ],
            ),
            Positioned(
              top: constraints.maxHeight * NumberConstant.welcomeMicTopFactor,
              right: constraints.maxWidth * NumberConstant.welcomeMicRightFactor,
              child: FadeSlideIn(
                delay: _micDelay,
                child: SizedBox(
                  width: constraints.maxWidth * NumberConstant.welcomeMicWidthFactor,
                  child: const _FloatingMic(),
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
        Image.asset(AssetRes.welcomeImg, fit: .cover),
        Align(
          alignment: .bottomCenter,
          child: Container(
            height: NumberConstant.welcomeGradientHeight,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: .topCenter,
                end: .bottomCenter,
                colors: [
                  AppColors.backgroundColor.withValues(alpha: 0),
                  AppColors.backgroundColor,
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
      padding: .fromLTRB(
        NumberConstant.horizontalPadding,
        NumberConstant.headerGap,
        NumberConstant.horizontalPadding,
        NumberConstant.sectionGap,
      ),
      child: Column(
        spacing: NumberConstant.sectionGap,
        mainAxisAlignment: .center,
        children: [
          FadeSlideIn(
            delay: _titleDelay,
            child: Text(
              StringConst.learnNewThings,
              style: AppTextStyles.welcomeTitle,
              textAlign: .center,
            ),
          ),
          FadeSlideIn(
            delay: _subtitleDelay,
            child: Text(
              StringConst.welcomeSubtitle,
              style: AppTextStyles.welcomeSubtitle,
              textAlign: .center,
            ),
          ),
          FadeSlideIn(
            delay: _ctaDelay,
            child: const _GetStartedButton(),
          ),
        ],
      ),
    );
  }
}

class _FloatingMic extends StatefulWidget {
  const _FloatingMic();

  @override
  State<_FloatingMic> createState() => _FloatingMicState();
}

class _FloatingMicState extends State<_FloatingMic>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _float;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: NumberConstant.welcomeMicFloatMs),
    );
    _float = Tween<double>(
      begin: -NumberConstant.welcomeMicFloatPx,
      end: NumberConstant.welcomeMicFloatPx,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.disableAnimationsOf(context)) return;
      _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _float,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, _float.value),
        child: child,
      ),
      child: Transform.rotate(
        angle: NumberConstant.welcomeMicAngleDeg * math.pi / 180,
        child: Image.asset(AssetRes.micImg, fit: .contain),
      ),
    );
  }
}

class _GetStartedButton extends StatefulWidget {
  const _GetStartedButton();

  @override
  State<_GetStartedButton> createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<_GetStartedButton> {
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
      onTap: () => context.go(NamedRoutes.discover.routeName),
      child: AnimatedScale(
        scale: _pressed ? NumberConstant.welcomeCtaPressScale : 1,
        duration: const Duration(milliseconds: NumberConstant.animFastMs),
        curve: Curves.easeOutCubic,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: .circular(NumberConstant.pillRadius),
          ),
          padding: .symmetric(
            horizontal: NumberConstant.buttonPaddingHorizontal,
            vertical: NumberConstant.buttonPaddingVertical,
          ),
          child: Text(StringConst.getStarted, style: AppTextStyles.button),
        ),
      ),
    );
  }
}
