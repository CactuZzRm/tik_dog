import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:tik_dog/constants.dart';
import 'package:tik_dog/pages/auth_loading_page/auth_loading_page.dart';

import '../../themes.dart';
import '../auth_information_page/auth_information_page.dart';
import '../auth_page/bloc/auth_bloc.dart';
import '../error_page/error_page.dart';
import '../wallet_page/bloc/wallet_bloc.dart';

class AuthStatisticPage extends StatelessWidget {
  const AuthStatisticPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final walletModel = context.read<WalletBloc>();

    return BlocListener<WalletBloc, WalletState>(
      listener: (context, state) {
        if (state is WalletCurrentState) {
          final isTikTok = context.read<AuthBloc>().isTikTok;
          isTikTok ? AdaptiveTheme.of(context).setDark() : AdaptiveTheme.of(context).setLight();
          selectedSymbol = isTikTok ? 'assets/images/TikTokSymbol' : 'assets/images/InstagramSymbol';

          final walletModel = context.read<WalletBloc>();

          walletModel.add(SaveUserId());
          walletModel.add(GroupUserById());
        }
      },
      child: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletLoadingState) {
            return const Center(child: AnimatedHorizontalSteps());
          } else if (state is WalletCurrentState) {
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
                        StatisticContainer(title: 'Videos', value: state.user.numberOfVideoMedia.toString()),
                        if (state.user.provider != 'tiktok') ...[
                          const SizedBox(height: 4),
                          StatisticContainer(title: 'Photos', value: state.user.numberOfImageMedia.toString()),
                        ] else
                          const SizedBox(height: 39 + 16),
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
                          walletModel.isTikTokSelect ? 'Wow! You have an amazing profile!' : 'Legendary status!',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontSize: 13,
                                fontWeight: walletModel.isTikTokSelect ? FontWeight.w400 : FontWeight.w500,
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
                        top: 222,
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
          return const Center(child: ErrorPage());
        },
      ),
    );
  }
}

class StatisticDetails extends StatelessWidget {
  const StatisticDetails({super.key});

  String formatNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      final result = number / 1000;
      return '${result.toStringAsFixed(1)}k';
    } else if (number < 1000000000) {
      final result = number / 1000000;
      return '${result.toStringAsFixed(1)}kk';
    } else {
      final result = number / 1000000000;
      return '${result.toStringAsFixed(1)}b';
    }
  }

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
                  StatisticCountContainer(
                    text: 'Views',
                    value: formatNumber(state.user.numberOfMediaViews),
                    margin: const EdgeInsets.only(left: 0, bottom: 37),
                  ),
                  StatisticCountContainer(
                    text: 'Likes',
                    value: formatNumber(state.user.numberOfLikes),
                    margin: const EdgeInsets.only(right: 0, bottom: 37),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatisticCountContainer(
                    text: 'Shared',
                    value: formatNumber(state.user.numberOfShares),
                    margin: const EdgeInsets.only(left: 0),
                  ),
                  StatisticCountContainer(
                    text: 'Comments',
                    value: formatNumber(state.user.numberOfComments),
                    margin: const EdgeInsets.only(right: 0),
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
