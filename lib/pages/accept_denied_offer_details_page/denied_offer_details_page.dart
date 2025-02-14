import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

import '../../themes.dart';
import '../auth_information_page/auth_information_page.dart';
import '../offers_page/bloc/offers_bloc.dart';
import 'components/reason_block.dart';

int? selectedReason;

class DeniedOfferDetailsPage extends StatefulWidget {
  const DeniedOfferDetailsPage({super.key});

  @override
  State<DeniedOfferDetailsPage> createState() => _DeniedOfferDetailsPageState();
}

class _DeniedOfferDetailsPageState extends State<DeniedOfferDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<OffersBloc>();

    return BlocBuilder<OffersBloc, OffersState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).extension<CustomThemeData>()!.offerDeniedReasonScaffoldBackgroundColor!,
          body: Column(
            children: [
              const Spacer(),
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
                        color: Theme.of(context).extension<CustomThemeData>()!.offerDeniedReasonSelectBackgroundColor!,
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
                          const Text(
                            'Reason for refusal',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              height: 1.32,
                            ),
                          ),
                          const SizedBox(height: 27),
                          ...[
                            for (int i = 0; i < model.reasons!.length; i++) ...[
                              const SizedBox(height: 35),
                              ReasonBlock(
                                text: model.reasons![i],
                                index: i,
                              ),
                            ],
                          ],
                          const SizedBox(height: 28),
                          GradientContainer(
                            isActive: model.selectedTextReason != null && model.selectedTextReason != '',
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                            child: ActionButton(
                              onPressed: model.selectedTextReason != null && model.selectedTextReason != ''
                                  ? () {
                                      model.deniedOffer(
                                        id: model.offers[0].id,
                                        reason: model.selectedTextReason!,
                                      );
                                      model.add(RemoveSelectedValuesEvent());
                                      context.pop();
                                    }
                                  : null,
                              isActive: model.selectedTextReason != null && model.selectedTextReason != '',
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
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
