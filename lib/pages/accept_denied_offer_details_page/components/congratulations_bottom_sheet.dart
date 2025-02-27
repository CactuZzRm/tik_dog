import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'dart:math' as math;

import '../../../constants.dart';
import '../../../themes.dart';
import '../../auth_information_page/auth_information_page.dart';
import '../../auth_statistic_page/auth_statistic_page.dart';

class CongratulationsBottomSheet extends StatelessWidget {
  final String email;
  const CongratulationsBottomSheet({
    required this.email,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 7.0,
            sigmaY: 7.0,
            tileMode: TileMode.clamp,
          ),
          child: const SizedBox(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Theme.of(context).splashColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    top: 20,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 12),
                        child: SvgPicture.asset(
                          'assets/icons/Cross.svg',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      ...[
                        Positioned(
                          right: -30,
                          bottom: 49,
                          child: Image.asset(
                            fit: BoxFit.cover,
                            AdaptiveTheme.of(context).mode.isDark
                                ? 'assets/images/BlueTorch.png'
                                : 'assets/images/RedTorch.png',
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 66,
                          child: Image.asset(
                            height: 358,
                            fit: BoxFit.cover,
                            // 'assets/images/TikTokSymbolCongr.png',
                            '${selectedSymbol}Congr.png',
                          ),
                        ),
                        Positioned(
                          bottom: 240,
                          right: 120,
                          child: Image.asset('${selectedSymbol}AcceptOfferCongrLogo.png'),
                        ),
                      ],
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 164,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              tileMode: TileMode.decal,
                              colors: [
                                Theme.of(context).extension<CustomThemeData>()!.offersAcceptGradientFirstColor!,
                                Theme.of(context).extension<CustomThemeData>()!.offersAcceptGradientSecondColor!,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 40),
                            AdaptiveTheme.of(context).mode.isDark
                                ? Text(
                                    'Congratulations',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromRGBO(255, 29, 101, 1),
                                        ),
                                  )
                                : GradientedText(
                                    text: 'Congratulations',
                                    textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromRGBO(255, 29, 101, 1),
                                        ),
                                  ),
                            const SizedBox(height: 25),
                            Row(
                              children: [
                                Transform.rotate(
                                  angle: -24.87 * math.pi / 180,
                                  child: Text(
                                    '🥳',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w600,
                                          height: 1.2,
                                        ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    'Wait for the brief from the advertiser',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          height: 1.21,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                'You will receive a notification by email',
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      height: 1.28,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 24,
                                horizontal: 33,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).highlightColor,
                                borderRadius: BorderRadius.circular(10),
                                border: AdaptiveTheme.of(context).mode.isLight
                                    ? Border.all(color: const Color.fromRGBO(225, 225, 225, 1))
                                    : null,
                              ),
                              child: Text(
                                email,
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      height: 1.2,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 35),
                            GradientContainer(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ActionButton(
                                onPressed: () {
                                  context.replaceNamed('OffersPage');
                                },
                                text: 'Ok',
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            const SizedBox(height: 21),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
