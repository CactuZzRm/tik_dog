import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

import '../../themes.dart';
import '../auth_page/auth_page.dart';
import '../auth_views_page/auth_views_page.dart';
import '../tabs_page/tabs_page.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 82 - 156 / 2,
          left: 0,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: Image.asset('assets/images/BlueTorch.png'),
          ),
        ),
        Column(
          children: [
            TabsHeader(
              text: '',
              currentIndex: 3,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17),
                child: ListView(
                  padding: const EdgeInsets.all(0),
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    Text(
                      'Balance',
                      style: TextStyle(fontSize: 15, height: 1.27),
                    ),
                    const SizedBox(height: 27),
                    Text(
                      '0\$',
                      style: TextStyle(
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
                    const SizedBox(height: 40),
                    Text(
                      'Withdraw funds to your card or bank account, worldwide: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '''Minimum withdrawl amount \$10For domestic transactions in US: 2.9%+\$0.30\nInternational payments: 3,9%+\$1\nCurrency conversion: an additional 1% if currency conversion is requiredInstant transfers to your debit or credit card Withdrawals to a bank account take 3-5 b days''',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 26),
                    Row(
                      children: [
                        SocialNetworkButton(
                          text: 'TikTok',
                          iconUrl: 'assets/icons/TikTokLogo.svg',
                        ),
                        const SizedBox(width: 12),
                        SocialNetworkButton(
                          text: 'Instagram',
                          iconUrl: 'assets/icons/InstagramLogo.svg',
                          isTikTok: false,
                        ),
                      ],
                    ),
                    SizedBox(height: 58),
                    WalletAccountActionButton(
                      text: 'Log out',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => WalletAccoundActionDialog(
                            text: 'Log out',
                            desc: 'Are you sure?',
                            buttonText: 'Yes',
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 12),
                    WalletAccountActionButton(
                      text: 'Delete account',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => WalletAccoundActionDialog(
                            text: 'Delete an account',
                            desc:
                                'All progress and data will be deleted along with the account.',
                            buttonText: 'Ok, delete',
                          ),
                        );
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
      color: Theme.of(context)
          .extension<CustomThemeData>()!
          .offerDeniedReasonScaffoldBackgroundColor!,
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
            color: Theme.of(context)
                .extension<CustomThemeData>()!
                .offersAcceptGradientFirstColor!,
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
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  height: 1.32,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              const SizedBox(height: 35),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1.44,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              const SizedBox(height: 40),
              GradientContainer(
                color: Color.fromRGBO(73, 73, 75, 1),
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
  const WalletAccountActionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Theme.of(context)
              .extension<CustomThemeData>()!
              .walletAccountActionButtonBackgroundColor!,
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Theme.of(context)
                  .extension<CustomThemeData>()!
                  .walletAccountActionButtonBorderColor!,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
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
      //TODO: Переделать на gradient container
      padding: const EdgeInsets.only(
        top: 12,
        right: 22,
        bottom: 11,
        left: 14,
      ),
      decoration: BoxDecoration(
        color: isTikTok == true
            ? Theme.of(context)
                .extension<CustomThemeData>()!
                .walletTikTokButtonBackgroundColor!
            : null,
        gradient: isTikTok == false
            ? LinearGradient(colors: [
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
          style: TextStyle(
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
