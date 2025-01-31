import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

import '../../themes.dart';
import '../auth_information_page/auth_information_page.dart';

int? selectedReason;

class DeniedOfferDetailsPage extends StatefulWidget {
  const DeniedOfferDetailsPage({super.key});

  @override
  State<DeniedOfferDetailsPage> createState() => _DeniedOfferDetailsPageState();
}

class _DeniedOfferDetailsPageState extends State<DeniedOfferDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .extension<CustomThemeData>()!
          .offerDeniedReasonScaffoldBackgroundColor!,
      body: Column(
        children: [
          Spacer(),
          Stack(
            children: [
              Positioned(
                top: 86 - 156 / 2,
                left: 20,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: Image.asset('assets/images/BlueTorch.png'),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 7.0,
                  sigmaY: 7.0,
                  tileMode: TileMode.clamp,
                ),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 16,
                    bottom: 42,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .extension<CustomThemeData>()!
                        .offerDeniedReasonSelectBackgroundColor!,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => context.pop(),
                          child: SvgPicture.asset('assets/icons/Cross.svg'),
                        ),
                      ),
                      Text(
                        'Reason for refusal',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          height: 1.32,
                        ),
                      ),
                      const SizedBox(height: 27),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedReason = 0;
                          });
                        },
                        child: ReasonBlock(
                          text: 'I do not live where Amazon is available',
                          index: 0,
                        ),
                      ),
                      if (selectedReason != null && selectedReason == 0) ...[
                        const SizedBox(height: 16),
                        ReasonTextField(
                          hintText:
                              'Are you ready to promote sellers in your region?: yes/no',
                        ),
                      ],
                      const SizedBox(height: 35),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedReason = 1;
                          });
                        },
                        child: ReasonBlock(
                          text: 'Personal circumstances:',
                          index: 1,
                        ),
                      ),
                      if (selectedReason != null && selectedReason == 1) ...[
                        const SizedBox(height: 16),
                        ReasonTextField(
                          hintText: 'Pls tell us more',
                        ),
                      ],
                      const SizedBox(height: 35),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedReason = 2;
                          });
                        },
                        child: ReasonBlock(
                          text: 'I find referral sharingprograms uninteresting',
                          index: 2,
                        ),
                      ),
                      if (selectedReason != null && selectedReason == 2) ...[
                        const SizedBox(height: 16),
                        ReasonTextField(
                          hintText:
                              'Ready to receive an offer that includes payment: yes/no',
                        ),
                      ],
                      const SizedBox(height: 35),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedReason = 3;
                          });
                        },
                        child: ReasonBlock(
                          text: 'Low payment for advertising',
                          index: 3,
                        ),
                      ),
                      if (selectedReason != null && selectedReason == 3) ...[
                        const SizedBox(height: 16),
                        ReasonTextField(
                          hintText: 'Your desired price is:',
                        ),
                      ],
                      const SizedBox(height: 35),
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedReason = 4;
                          });
                        },
                        child: ReasonBlock(
                          text: 'Other',
                          index: 4,
                        ),
                      ),
                      if (selectedReason != null && selectedReason == 4) ...[
                        const SizedBox(height: 16),
                        ReasonTextField(
                          hintText: 'Pls tell us more',
                        ),
                      ],
                      const SizedBox(height: 28),
                      GradientContainer(
                        isActive: selectedReason != null,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: ActionButton(
                          onPressed: selectedReason != null
                              ? () => debugPrint('PLACEHOLDER: Click')
                              : null,
                          text: 'Send',
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class ReasonTextField extends StatelessWidget {
  final String hintText;
  const ReasonTextField({
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 2,
      maxLines: 2,
      style: TextStyle(fontSize: 15, height: 1.22),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
          top: 18,
          right: 16,
          bottom: 25,
          left: 16,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Theme.of(context)
              .extension<CustomThemeData>()!
              .offerDeniedReasonTextFieldHintColor!,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(137, 137, 137, 1),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class ReasonBlock extends StatelessWidget {
  final String text;
  final int index;
  const ReasonBlock({super.key, required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: index == selectedReason
                  ? AdaptiveTheme.of(context).mode.isDark
                      ? Color.fromRGBO(255, 29, 101, 1)
                      : Color.fromRGBO(181, 61, 173, 1)
                  : Color.fromRGBO(128, 128, 128, 1),
            ),
          ),
          child: index == selectedReason
              ? Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AdaptiveTheme.of(context).mode.isDark
                        ? Color.fromRGBO(255, 29, 101, 1)
                        : Color.fromRGBO(181, 61, 173, 1),
                  ),
                )
              : SizedBox(height: 14, width: 14),
        ),
      ],
    );
  }
}
