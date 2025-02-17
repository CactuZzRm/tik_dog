import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:tik_dog/constants.dart';

import '../../themes.dart';
import '../auth_information_page/auth_information_page.dart';
import '../auth_page/bloc/auth_bloc.dart';
import '../wallet_page/bloc/wallet_bloc.dart';

class AuthStatisticPage extends StatelessWidget {
  // final String? buttonRedirectPageName;
  // final String buttonText;

  const AuthStatisticPage({
    super.key,
    // this.buttonRedirectPageName,
    // required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state is WalletCurrentState) {
          return Screenshot(
            controller: context.read<WalletBloc>().screenshotController,
            child: Scaffold(
              body: Stack(
                children: [
                  ...[
                    if (AdaptiveTheme.of(context).mode.isDark)
                      Positioned(
                        bottom: 172,
                        right: 0,
                        child: Image.asset('assets/images/BlueTorch.png'),
                      ),
                    Positioned(
                      bottom: 220 + MediaQuery.of(context).padding.bottom,
                      right: 0,
                      child: Image.asset(AdaptiveTheme.of(context).mode.isDark
                          ? 'assets/images/DarkSteps.png'
                          : 'assets/images/LightSteps.png'),
                    ),
                    Positioned(
                      bottom: 180 + MediaQuery.of(context).padding.bottom,
                      left: MediaQuery.of(context).size.width * 0.5 - 117,
                      child: Image.asset('${selectedSymbol}Full.png'),
                    ),
                  ],
                  Column(
                    children: [
                      SizedBox(height: 26 + MediaQuery.of(context).padding.top),
                      StatisticContainer(title: 'Subscribers', value: state.user.numberOfFollowers.toString()),
                      const SizedBox(height: 4),
                      StatisticContainer(title: 'Videos', value: state.user.numberOfMedia.toString()),
                      const SizedBox(height: 45),
                      const StatisticDetails(),
                      const Spacer(),
                      GradientContainer(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ActionButton(
                          onPressed: () => context.replaceNamed('AuthInformationPage'),
                          text: 'Next',
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(height: 18),
                      ActionButton(
                        onPressed: () async {
                          // debugPrint('PLACEHOLDER: SHARE');
                          await context.read<WalletBloc>().getScreen();
                        },
                        text: 'Share',
                        backgroundColor: Theme.of(context).cardColor,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        context.read<AuthBloc>().isTikTok ? 'Wow! You have an amazing profile!' : 'Legendary status!',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 13,
                              fontWeight: context.read<AuthBloc>().isTikTok ? FontWeight.w400 : FontWeight.w500,
                              height: 1,
                            ),
                      ),
                      SizedBox(height: 21 + MediaQuery.of(context).padding.bottom),
                    ],
                  ),
                  ...[
                    const Positioned(
                      top: 164,
                      left: -31,
                      child: Text('🔥', style: TextStyle(fontSize: 64)),
                    ),
                    const Positioned(
                      top: 183,
                      right: 5,
                      child: Text('🔥', style: TextStyle(fontSize: 32)),
                    ),
                    const Positioned(
                      top: 480,
                      left: 20,
                      child: Text('🔥', style: TextStyle(fontSize: 32)),
                    ),
                    const Positioned(
                      top: 490,
                      right: 22,
                      child: Text('🔥', style: TextStyle(fontSize: 20)),
                    ),
                    Positioned(
                      bottom: 141,
                      left: 0,
                      child: Image.asset('${selectedSymbol}LogoReversed.png'),
                    ),
                  ]
                ],
              ),
            ),
          );
        }
        return const Center(child: Text('error'));
      },
    );
  }
}

class StatisticDetails extends StatelessWidget {
  const StatisticDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state is WalletCurrentState) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const StatisticCountContainer(
                    text: 'of video',
                    value: '870k',
                    margin: EdgeInsets.only(left: 35, bottom: 45),
                  ),
                  StatisticCountContainer(
                    text: 'Views',
                    //TODO: Скорректировать плавающую точку
                    value: state.user.numberOfMediaViews.toString(),
                    margin: const EdgeInsets.only(right: 22, bottom: 45),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatisticCountContainer(
                    text: 'Shared',
                    value: '1.5k',
                    margin: EdgeInsets.only(left: 32, bottom: 45),
                  ),
                  StatisticCountContainer(
                    text: 'Comments',
                    value: '870k',
                    margin: EdgeInsets.only(
                      top: 18,
                      right: 28,
                      bottom: 45,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return const Center(child: Text('errorus'));
      },
    );
  }
}

class StatisticContainer extends StatelessWidget {
  final String title;
  final String value;
  const StatisticContainer({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 14,
        right: 17,
        bottom: 14,
        left: 21,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).hintColor,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).extension<CustomThemeData>()!.authStatisticsPagestatisticContainerTextColor,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).extension<CustomThemeData>()!.authStatisticsPagestatisticContainerTextColor,
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
    required this.margin,
  });
  final String text;
  final String value;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AdaptiveTheme.of(context).mode.isDark
                ? Stack(
                    children: [
                      Positioned(
                        left: 2,
                        child: Text(
                          value,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: const Color.fromRGBO(254, 44, 85, 1),
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Positioned(
                        right: 2,
                        child: Text(
                          value,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: const Color.fromRGBO(4, 211, 237, 1),
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Text(
                        value,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  )
                : GradientedText(text: value),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientedText extends StatelessWidget {
  const GradientedText({
    super.key,
    required this.text,
    this.textStyle,
  });

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GradientText(
      text,
      style: textStyle ??
          Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
      colors: const [
        Color.fromRGBO(108, 34, 193, 1),
        Color.fromRGBO(229, 36, 69, 1),
      ],
    );
  }
}
