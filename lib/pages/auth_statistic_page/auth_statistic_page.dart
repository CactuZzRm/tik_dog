import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:tik_dog/constants.dart';

import '../../themes.dart';
import '../auth_information_page/auth_information_page.dart';
import '../wallet_page/bloc/wallet_bloc.dart';

class AuthStatisticPage extends StatelessWidget {
  final String? buttonRedirectPageName;
  final String buttonText;

  const AuthStatisticPage({
    super.key,
    this.buttonRedirectPageName,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state is WalletCurrentState) {
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
                      bottom: 180,
                      left: MediaQuery.of(context).size.width * 0.5 - 117,
                      child: Image.asset('${selectedSymbol}Full.png'),
                    ),
                  ],
                  Column(
                    children: [
                      const SizedBox(height: 26),
                      StatisticContainer(title: 'Subscribers', value: state.user.numberOfFollowers.toString()),
                      const SizedBox(height: 4),
                      StatisticContainer(title: 'Videos', value: state.user.numberOfMedia.toString()),
                      const SizedBox(height: 45),
                      StatisticDetails(),
                      Spacer(),
                      GradientContainer(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ActionButton(
                          onPressed: () => buttonRedirectPageName != null
                              ? context.replaceNamed('AuthInformationPage')
                              : context.pop(),
                          text: buttonText,
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      const SizedBox(height: 18),
                      ActionButton(
                        onPressed: () {
                          debugPrint('PLACEHOLDER: SHARE');
                        },
                        text: 'Share',
                        backgroundColor: Theme.of(context).cardColor,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'Wow! You have an amazing profile!',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  ...[
                    Positioned(
                      top: 112,
                      left: -40,
                      child: Text('🔥', style: TextStyle(fontSize: 64)),
                    ),
                    Positioned(
                      top: 152,
                      right: 5,
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
                      bottom: 120,
                      left: 0,
                      child: Image.asset('${selectedSymbol}LogoReversed.png'),
                    ),
                  ]
                ],
              ),
            ),
          );
        }
        return Center(child: Text('error'));
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
                  StatisticCountContainer(
                    text: 'of video',
                    value: '870k',
                    margin: const EdgeInsets.only(left: 35, bottom: 45),
                  ),
                  StatisticCountContainer(
                    text: 'Views',
                    //TODO: Скорректировать плавающую точку
                    value: state.user.numberOfMediaViews.toString(),
                    margin: const EdgeInsets.only(right: 22, bottom: 45),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatisticCountContainer(
                    text: 'Shared',
                    value: '1.5k',
                    margin: const EdgeInsets.only(left: 32, bottom: 45),
                  ),
                  StatisticCountContainer(
                    text: 'Comments',
                    value: '870k',
                    margin: const EdgeInsets.only(
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
        return Center(child: Text('error'));
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
                                color: Color.fromRGBO(254, 44, 85, 1),
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
                                color: Color.fromRGBO(4, 211, 237, 1),
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Text(
                        value,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Color.fromRGBO(255, 255, 255, 1),
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
      colors: [
        Color.fromRGBO(108, 34, 193, 1),
        Color.fromRGBO(229, 36, 69, 1),
      ],
    );
  }
}
