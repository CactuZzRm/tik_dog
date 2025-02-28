// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_dog/constants.dart';
import 'package:tik_dog/data/api/models/group_user_model.dart';
import 'package:tik_dog/data/repositories/wallet_repository_impl.dart';
import 'package:tik_dog/pages/wallet_page/bloc/wallet_bloc.dart';
import 'dart:math' as math;

import '../../injection_container.dart';
import '../../themes.dart';
import '../auth_information_page/auth_information_page.dart';
import '../auth_page/bloc/auth_bloc.dart';
import '../tabs_page/tabs_page.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  void logOut() {
    if (getIt<SharedPreferences>().getString('tiktok_token') != null) {
      getIt<SharedPreferences>().remove('tiktok_token');
    }
    if (getIt<SharedPreferences>().getString('instagram_token') != null) {
      getIt<SharedPreferences>().remove('instagram_token');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (AdaptiveTheme.of(context).mode.isDark)
          Positioned(
            top: 82 - 156 / 2,
            left: -156 / 2,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image.asset('assets/images/BlueTorch.png'),
            ),
          ),
        Column(
          children: [
            const TabsHeader(
              currentIndex: 3,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  children: [
                    const SizedBox(height: 25),
                    Text(
                      'Balance',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15, height: 1.27),
                    ),
                    const SizedBox(height: 27),
                    Text(
                      '0\$',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            height: 1.23,
                          ),
                    ),
                    const SizedBox(height: 35),
                    GradientContainer(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ActionButton(
                        onPressed: () => debugPrint('PLACEHOLDER: Click'),
                        backgroundColor: Colors.transparent,
                        text: 'Withdrawal',
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      padding: const EdgeInsets.only(
                        right: 13,
                        left: 17,
                        top: 22,
                        bottom: 22,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        border: Border.all(
                          color: const Color.fromRGBO(255, 29, 101, 1),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset(
                              'assets/icons/ShareArrow.svg',
                              color: Theme.of(context).textTheme.bodyMedium!.color,
                            ),
                          ),
                          const SizedBox(height: 17),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Subscribe to tiktok',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        height: 1.22,
                                      ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(child: Image.asset('assets/images/SubscribeTikTokImages.png')),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(108, 34, 193, 1),
                            Color.fromRGBO(229, 36, 69, 1),
                          ],
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                          right: 13,
                          left: 17,
                          top: 22,
                          bottom: 22,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: SvgPicture.asset(
                                'assets/icons/ShareArrow.svg',
                                color: Theme.of(context).textTheme.bodyMedium!.color,
                              ),
                            ),
                            const SizedBox(height: 17),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Subscribe to instagram',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          height: 1.22,
                                        ),
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(child: Image.asset('assets/images/SubscribeInstagramImages.png')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => context.pushNamed('StatisticPage'),
                      child: Container(
                        height: 108,
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
                        decoration: BoxDecoration(
                          color: AdaptiveTheme.of(context).mode.isDark ? const Color.fromRGBO(255, 29, 101, 1) : null,
                          gradient: AdaptiveTheme.of(context).mode.isLight
                              ? const LinearGradient(colors: [
                                  Color.fromRGBO(108, 34, 193, 1),
                                  Color.fromRGBO(229, 36, 69, 1),
                                ])
                              : null,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            alignment: Alignment.centerRight,
                            image: AssetImage('${selectedSymbol}StatisticBackgroundImage.png'),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Your statistics',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  height: 1.13,
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 35),
                    WalletAccountActionButton(
                      text: 'Log out',
                      onPressed: () {
                        if (Platform.isIOS) {
                          showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: Text(
                                'Log out',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      height: 1.22,
                                    ),
                              ),
                              content: Text(
                                'Are you sure you want to get out?',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      height: 1.44,
                                    ),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text(
                                    'Cancel',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                          height: 1.22,
                                          color: Colors.blue,
                                        ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text(
                                    'Log out',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          height: 1.22,
                                          color: const Color.fromRGBO(255, 10, 14, 1),
                                        ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    logOut();
                                    context.go('/');
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actionsAlignment: MainAxisAlignment.end,
                              title: Text(
                                'Log out',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      height: 1.22,
                                    ),
                              ),
                              content: Text(
                                'Are you sure you want to get out?',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      height: 1.44,
                                    ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(
                                    'Cancel',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                          height: 1.22,
                                          color: Colors.blue,
                                        ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Log out',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          height: 1.22,
                                          color: const Color.fromRGBO(255, 10, 14, 1),
                                        ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    logOut();
                                    context.go('/');
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    WalletAccountActionButton(
                      text: 'Delete account',
                      onPressed: () {
                        if (Platform.isIOS) {
                          showDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: Text(
                                'Delete an account',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      height: 1.22,
                                    ),
                              ),
                              content: Text(
                                'All progress and data will be deleted along with the account.',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      height: 1.44,
                                    ),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text(
                                    'Cancel',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                          height: 1.22,
                                          color: Colors.blue,
                                        ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text(
                                    'Delete',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          height: 1.22,
                                          color: const Color.fromRGBO(255, 10, 14, 1),
                                        ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              actionsAlignment: MainAxisAlignment.end,
                              title: Text(
                                'Delete an account',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      height: 1.22,
                                    ),
                              ),
                              content: Text(
                                'All progress and data will be deleted along with the account.',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      height: 1.44,
                                    ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(
                                    'Cancel',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400,
                                          height: 1.22,
                                          color: Colors.blue,
                                        ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Delete',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          height: 1.22,
                                          color: const Color.fromRGBO(255, 10, 14, 1),
                                        ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 21),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class WalletAccoundActionDialog extends StatelessWidget {
  final String text;
  final String desc;
  final String buttonText;

  const WalletAccoundActionDialog({
    super.key,
    required this.text,
    required this.desc,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).extension<CustomThemeData>()!.offerDeniedReasonScaffoldBackgroundColor!,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          padding: const EdgeInsets.only(
            top: 16,
            right: 16,
            bottom: 29,
            left: 16,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).extension<CustomThemeData>()!.offersAcceptGradientFirstColor!,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: SvgPicture.asset('assets/icons/Cross.svg'),
                ),
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      height: 1.32,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
              ),
              const SizedBox(height: 35),
              Text(
                desc,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.44,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
              ),
              const SizedBox(height: 40),
              GradientContainer(
                color: const Color.fromRGBO(73, 73, 75, 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ActionButton(
                  text: buttonText,
                  onPressed: () => debugPrint('PLACEHOLDER: CLICK'),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WalletAccountActionButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final EdgeInsets? margin;
  const WalletAccountActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Theme.of(context).extension<CustomThemeData>()!.walletAccountActionButtonBackgroundColor!,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Theme.of(context).extension<CustomThemeData>()!.walletAccountActionButtonBorderColor!,
            ),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
        ),
      ),
    );
  }
}

class SocialNetworkButton extends StatelessWidget {
  final String text;
  final String iconUrl;
  final bool isTikTok;
  const SocialNetworkButton({
    super.key,
    required this.text,
    required this.iconUrl,
    this.isTikTok = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 12,
        right: 22,
        bottom: 11,
        left: 14,
      ),
      decoration: BoxDecoration(
        color: isTikTok == true
            ? Theme.of(context).extension<CustomThemeData>()!.walletTikTokButtonBackgroundColor!
            : null,
        gradient: isTikTok == false
            ? const LinearGradient(colors: [
                Color.fromRGBO(108, 34, 193, 1),
                Color.fromRGBO(229, 36, 69, 1),
              ])
            : null,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(children: [
        SvgPicture.asset(
          iconUrl,
          height: 17,
          width: 17,
        ),
        const SizedBox(width: 13),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.27,
                color: Colors.white,
              ),
        )
      ]),
    );
  }
}
