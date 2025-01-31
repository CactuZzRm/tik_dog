import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../constants.dart';
import '../auth_statistic_page/auth_statistic_page.dart';

class AuthViewsPage extends StatelessWidget {
  const AuthViewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ...[
              if (AdaptiveTheme.of(context).mode.isDark)
                Positioned(
                  bottom: 120,
                  right: 0,
                  child: Image.asset('assets/images/BlueTorch.png'),
                ),
              Positioned(
                bottom: 200,
                right: 0,
                child: Image.asset(AdaptiveTheme.of(context).mode.isDark
                    ? 'assets/images/DarkSteps.png'
                    : 'assets/images/LightSteps.png'),
              ),
              Positioned(
                bottom: 121,
                left: MediaQuery.of(context).size.width * 0.5 - 117,
                child: Image.asset('${selectedSymbol}Full.png'),
              ),
            ],
            Column(
              children: [
                const SizedBox(height: 57),
                AchivmentBlock(
                  text: 'Wow! You have an amazing profile! You\'re in the Top 5% TikTok users',
                ),
                const SizedBox(height: 57), //todo: REMOVE
                StatisticCountContainer(text: 'Views', value: '100.5M'),
                Spacer(),
                GradientContainer(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ActionButton(
                    onPressed: () {
                      // debugPrint('PLACEHOLDER: NEXT');
                      context.goNamed('OffersPage');
                    },
                    text: 'Next',
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 18),
                ActionButton(
                  onPressed: () {
                    debugPrint('PLACEHOLDER: SHARE');
                  },
                  text: 'Share',
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  backgroundColor: Theme.of(context).cardColor,
                ),
                const SizedBox(height: 23),
              ],
            ),
            ...[
              Positioned(
                top: 255,
                left: -30,
                child: Text('🔥', style: TextStyle(fontSize: 64)),
              ),
              Positioned(
                top: 172,
                right: 35,
                child: Text('🔥', style: TextStyle(fontSize: 32)),
              ),
              Positioned(
                top: 420,
                left: 20,
                child: Text('🔥', style: TextStyle(fontSize: 32)),
              ),
              Positioned(
                top: 420,
                right: 22,
                child: Text('🔥', style: TextStyle(fontSize: 20)),
              ),
              Positioned(
                bottom: 140,
                left: 0,
                child: Image.asset('${selectedSymbol}LogoReversed.png'),
              ),
              Positioned(
                top: 3,
                left: 4,
                child: Image.asset('assets/images/StepsTop.png'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AchivmentBlock extends StatelessWidget {
  final String text;
  const AchivmentBlock({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 32, right: 29, bottom: 28, left: 22),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).hintColor,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AdaptiveTheme.of(context).mode.isDark ? TripleText(value: '12') : GradientedText(text: '12'),
              Text(
                'Years on TikTok',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            ],
          ),
          SizedBox(width: 19),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1.24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatisticCountContainer extends StatelessWidget {
  const StatisticCountContainer({
    super.key,
    required this.text,
    required this.value,
  });
  final String text;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AdaptiveTheme.of(context).mode.isDark ? TripleText(value: value) : GradientedText(text: value),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class TripleText extends StatelessWidget {
  const TripleText({
    super.key,
    required this.value,
  });

  final String value;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Color.fromRGBO(4, 211, 237, 1),
            fontSize: 53,
            height: 1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3, top: 2),
          child: Text(
            value,
            style: TextStyle(
              color: Color.fromRGBO(254, 44, 85, 1),
              fontSize: 53,
              height: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 53,
              height: 1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class GradientContainer extends StatelessWidget {
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final Gradient? gradient;
  final Color? color;
  final Widget? child;
  final bool needBackground;

  const GradientContainer({
    super.key,
    this.width,
    this.margin,
    this.padding,
    this.decoration,
    this.child,
    this.gradient = const LinearGradient(colors: [
      Color.fromRGBO(108, 34, 193, 1),
      Color.fromRGBO(229, 36, 69, 1),
    ]),
    this.color = const Color.fromRGBO(219, 29, 101, 1),
    this.needBackground = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeMode = AdaptiveTheme.of(context).mode;
    final decorationBox =
        themeMode.isLight ? decoration!.copyWith(gradient: gradient) : decoration!.copyWith(color: color);

    return Container(
      width: width,
      padding: padding,
      margin: margin,
      decoration: needBackground ? decorationBox : decoration?.copyWith(color: Colors.transparent),
      child: child,
    );
  }
}

class ActionButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final Color? backgroundColor;
  final EdgeInsets? margin;
  final bool isActive;
  final Color? disabledBackgroundColor;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.margin,
    this.isActive = false,
    this.disabledBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: disabledBackgroundColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
