import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tik_dog/themes.dart';

import 'dart:math' as math;

import '../../constants.dart';
import '../auth_statistic_page/auth_statistic_page.dart';
import '../auth_views_page/auth_views_page.dart';

class AcceptOfferDetailsPage extends StatefulWidget {
  AcceptOfferDetailsPage({super.key});

  @override
  State<AcceptOfferDetailsPage> createState() => _AcceptOfferDetailsPageState();
}

class _AcceptOfferDetailsPageState extends State<AcceptOfferDetailsPage> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  bool selectCountryIsOpen = false;

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => context.pop(),
                      child: SvgPicture.asset(
                        'assets/icons/BackArrow.svg',
                        color: Theme.of(context).canvasColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Fill in your details to receive the briffrom Amazon sellers',
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      height: 1.36,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    '🏳️ Country',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Not selected',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).extension<CustomThemeData>()!.offersAcceptEmailHintColor!,
                              ),
                            ),
                          ),
                        ],
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onMenuStateChange: (flag) {
                        setState(() {
                          selectCountryIsOpen = flag;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: const EdgeInsets.only(left: 15, right: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Theme.of(context).extension<CustomThemeData>()!.offersAcceptEmailHintColor!,
                          ),
                          color: Colors.transparent,
                        ),
                        elevation: 0,
                      ),
                      iconStyleData: IconStyleData(
                        icon: RotationTransition(
                          turns: AlwaysStoppedAnimation(
                            selectCountryIsOpen ? 90 / 360 : -90 / 360,
                          ),
                          child: SvgPicture.asset('assets/icons/BackArrow.svg'),
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: MediaQuery.of(context).size.width - 16 * 2,
                        padding: const EdgeInsets.all(0),
                        maxHeight: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red, //TODO: Цвет заменить
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.only(
                          top: 15,
                          right: 12,
                          bottom: 17,
                          left: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 36),
                  Text(
                    '😎 Email',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).extension<CustomThemeData>()!.offersAcceptEmailHintColor!,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      style: TextStyle(
                        fontSize: 14,
                        height: 1,
                      ),
                      decoration: InputDecoration.collapsed(
                        hintText: 'Email address',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          height: 1,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Spacer(),
                  GradientContainer(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ActionButton(
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        useRootNavigator: true,
                        builder: (context) => CongratulationsBottomSheet(),
                      ),
                      text: 'Get an offer',
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 99,
              right: 0,
              child: Image.asset('assets/images/Step.png'),
            ),
          ],
        ),
      ),
    );
  }
}

class CongratulationsBottomSheet extends StatelessWidget {
  const CongratulationsBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container(
        //   color: Colors.red,
        // ),
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 7.0,
            sigmaY: 7.0,
            tileMode: TileMode.clamp,
          ),
          child: SizedBox(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            // height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).splashColor,
              // color: Colors.red,
              borderRadius: BorderRadius.only(
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
                    child: InkWell(
                      onTap: () => context.pop(),
                      child: SvgPicture.asset(
                        'assets/icons/Cross.svg',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
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
                                    style: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(255, 29, 101, 1),
                                    ),
                                  )
                                : GradientedText(
                                    text: 'Congratulations',
                                    textStyle: TextStyle(
                                      fontSize: 27,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(255, 29, 101, 1),
                                    ),
                                  ),
                            const SizedBox(height: 25),
                            Row(
                              children: [
                                Transform.rotate(
                                  angle: -24.87 * math.pi / 180,
                                  child: Text(
                                    '🥳',
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w600,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child: Expanded(
                                    child: Text(
                                      'Wait for the brief from the advertiser',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        height: 1.21,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                'You will receive a notification by email',
                                style: TextStyle(
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
                                    ? Border.all(color: Color.fromRGBO(225, 225, 225, 1))
                                    : null,
                              ),
                              child: Text(
                                '11111111@1111.11',
                                style: TextStyle(
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
                                onPressed: () => debugPrint('PLACEHOLDER: CLICK'),
                                text: 'Ok',
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            SizedBox(height: 21),
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
