import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'dart:math' as math;

import '../../constants.dart';
import '../auth_page/bloc/auth_bloc.dart';
import '../auth_statistic_page/auth_statistic_page.dart';
import '../wallet_page/bloc/wallet_bloc.dart';

class AuthInformationPage extends StatelessWidget {
  const AuthInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthBloc>();
    final walletModel = context.read<WalletBloc>();

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 122,
            left: 0,
            child: Image.asset('${selectedSymbol}LogoReversed.png'),
          ),
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
          ],
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                SizedBox(
                  height: 247 + MediaQuery.of(context).padding.top,
                  child: Stack(
                    children: [
                      if (walletModel.isTikTokSelect)
                        Positioned(
                          top: -20,
                          child: Image.asset('assets/images/AuthInformationPageTopMoney.png'),
                        ),
                      Positioned(
                        top: walletModel.isTikTokSelect ? -11 : 0,
                        left: 78,
                        right: 78,
                        child: Image.asset('${selectedSymbol}AuthInformationPageTopImage.png'),
                      ),
                      if (!walletModel.isTikTokSelect)
                        Positioned(
                          top: -50,
                          child: Image.asset('assets/images/AuthInformationPageTopMoney.png'),
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  'Wow!',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 33),
                Text(
                  'With such stats, you can earn good money!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 49),
                AdaptiveTheme.of(context).mode.isDark
                    ? Stack(
                        children: [
                          Positioned(
                            left: 3,
                            top: 2,
                            child: Text(
                              '\$15k',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: const Color.fromRGBO(254, 44, 85, 1),
                                    fontSize: 85,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Positioned(
                            bottom: 2,
                            right: 3,
                            child: Text(
                              '\$15k',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: const Color.fromRGBO(4, 211, 237, 1),
                                    fontSize: 85,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Text(
                            '\$15k',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 85,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      )
                    : GradientedText(
                        text: '\$15k',
                        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 85,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                const Spacer(),
                const SizedBox(height: 35),
                GradientContainer(
                  color: Theme.of(context).primaryColor,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ActionButton(
                    onPressed: () => context.replaceNamed('OffersPage'),
                    text: 'Next',
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 27),
                Text(
                  walletModel.isTikTokSelect ? 'Wow! You have an amazing profile!' : 'Legendary status!',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        height: 1,
                      ),
                ),
                const SizedBox(height: 21),
              ],
            ),
          ),
          if (walletModel.isTikTokSelect) ...[
            Positioned(
              top: MediaQuery.of(context).size.height * 0.47,
              left: 19,
              child: const Text('🤑'),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.40,
              right: 16,
              child: Transform.rotate(
                angle: math.pi * -15 / 180,
                child: Text(
                  '🤑',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 32),
                ),
              ),
            ),
            Positioned(
              bottom: 140 + MediaQuery.of(context).padding.bottom,
              right: 20,
              child: Transform.rotate(
                angle: math.pi * -30 / 180,
                child: Text(
                  '😱',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
                ),
              ),
            ),
          ] else ...[
            Positioned(
              top: MediaQuery.of(context).size.height * 0.47,
              left: 70,
              child: Transform.rotate(
                angle: math.pi * -15 / 180,
                child: Text(
                  '🤑',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.40,
              right: 37,
              child: Transform.rotate(
                angle: math.pi * 30 / 180,
                child: Text(
                  '🤑',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 32),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.6,
              left: -34,
              child: Transform.rotate(
                angle: math.pi * 15 / 180,
                child: Text(
                  '😱',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 64),
                ),
              ),
            ),
            Positioned(
              bottom: 150 + MediaQuery.of(context).padding.bottom,
              right: 26,
              child: Transform.rotate(
                angle: math.pi * -30 / 180,
                child: Text(
                  '😱',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
                ),
              ),
            ),
            Positioned(
              bottom: 150 - 27 + MediaQuery.of(context).padding.bottom,
              right: 26 + 8,
              child: Transform.rotate(
                angle: math.pi * -30 / 180,
                child: Text(
                  '😱',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20),
                ),
              ),
            ),
          ],
        ],
      ),
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
          style: const TextStyle(
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
            style: const TextStyle(
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
            style: const TextStyle(
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
  Gradient? gradient;
  Color? color;
  final Widget? child;
  final bool needBackground;
  final bool isActive;

  GradientContainer({
    super.key,
    this.width,
    this.margin,
    this.padding,
    this.decoration,
    this.isActive = true,
    this.child,
    this.gradient,
    this.color = const Color.fromRGBO(255, 29, 101, 1),
    this.needBackground = true,
  }) {
    gradient = isActive
        ? const LinearGradient(colors: [
            Color.fromRGBO(108, 34, 193, 1),
            Color.fromRGBO(255, 36, 69, 1),
          ])
        : const LinearGradient(colors: [
            Color.fromRGBO(108, 34, 193, 0.2),
            Color.fromRGBO(229, 36, 69, 0.2),
          ]);
    color = isActive ? color : color!.withValues(alpha: 0.2);
  }

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
  final Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final EdgeInsets? margin;
  final bool isActive;
  final Color? disabledBackgroundColor;
  final bool? isActivate;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.margin,
    this.isActive = true,
    this.disabledBackgroundColor,
    this.isActivate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: disabledBackgroundColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: isActive ? 1 : 0.2),
              ),
        ),
      ),
    );
  }
}
