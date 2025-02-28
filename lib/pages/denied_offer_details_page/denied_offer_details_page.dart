import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tik_dog/pages/auth_loading_page/auth_loading_page.dart';
import 'dart:math' as math;

import '../../data/api/models/offer_model.dart';
import '../../themes.dart';
import '../auth_information_page/auth_information_page.dart';
import 'components/reason_block.dart';
import 'cubit/denied_offer_details_cubit.dart';

class DeniedOfferDetailsPage extends StatelessWidget {
  final OfferModel offer;

  const DeniedOfferDetailsPage({required this.offer, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeniedOfferDetailsCubit()..fetchDeniedOfferReasons(),
      child: Scaffold(
        backgroundColor: Theme.of(context).extension<CustomThemeData>()!.offerDeniedReasonScaffoldBackgroundColor!,
        body: Column(
          children: [
            const Spacer(),
            BlocBuilder<DeniedOfferDetailsCubit, DeniedOfferDetailsState>(
              builder: (context, state) {
                if (state is DeniedOfferDetailsLoading) {
                  return const AnimatedHorizontalSteps();
                } else if (state is DeniedOfferDetailsCurrent) {
                  final model = context.read<DeniedOfferDetailsCubit>();

                  return Stack(
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
                          sigmaX: 0.0,
                          sigmaY: 0.0,
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
                            color:
                                Theme.of(context).extension<CustomThemeData>()!.offerDeniedReasonSelectBackgroundColor!,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () => context.pop(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12, bottom: 12),
                                    child: SvgPicture.asset('assets/icons/Cross.svg'),
                                  ),
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
                                for (int i = 0; i < state.reasons!.length; i++) ...[
                                  const SizedBox(height: 35),
                                  ReasonBlock(
                                    text: state.reasons![i],
                                    index: i,
                                    selectedReasonIndex: state.selectedReasonIndex,
                                  ),
                                ],
                              ],
                              const SizedBox(height: 28),
                              GradientContainer(
                                isActive: state.selectedTextReason != null && state.selectedTextReason != '',
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                child: ActionButton(
                                  onPressed: state.selectedTextReason != null && state.selectedTextReason != ''
                                      ? () {
                                          model.deniedOffer(
                                            id: offer.id,
                                            reason: state.selectedTextReason!,
                                          );
                                          context.pop();
                                        }
                                      : null,
                                  isActive: state.selectedTextReason != null && state.selectedTextReason != '',
                                  text: 'Send',
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const AnimatedHorizontalSteps();
                }
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// if (state is DeniedOfferDetailsLoading) {
//             return const Center(child: Text('loading'));
//           } else if (state is DeniedOfferDetailsCurrent) {
//             return Scaffold(
//               backgroundColor:
//                   Theme.of(context).extension<CustomThemeData>()!.offerDeniedReasonScaffoldBackgroundColor!,
//               body: Column(
//                 children: [
//                   const Spacer(),
//                   Stack(
//                     children: [
//                       Positioned(
//                         top: 86 - 156 / 2,
//                         left: 20,
//                         child: Transform(
//                           alignment: Alignment.center,
//                           transform: Matrix4.rotationY(math.pi),
//                           child: Image.asset('assets/images/BlueTorch.png'),
//                         ),
//                       ),
//                       BackdropFilter(
//                         filter: ImageFilter.blur(
//                           sigmaX: 0.0,
//                           sigmaY: 0.0,
//                           tileMode: TileMode.clamp,
//                         ),
//                         child: Container(
//                           width: double.infinity,
//                           margin: const EdgeInsets.symmetric(horizontal: 20),
//                           padding: const EdgeInsets.only(
//                             left: 20,
//                             right: 20,
//                             top: 16,
//                             bottom: 42,
//                           ),
//                           decoration: BoxDecoration(
//                             color:
//                                 Theme.of(context).extension<CustomThemeData>()!.offerDeniedReasonSelectBackgroundColor!,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                             children: [
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: GestureDetector(
//                                   behavior: HitTestBehavior.opaque,
//                                   onTap: () => context.pop(),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 12, bottom: 12),
//                                     child: SvgPicture.asset('assets/icons/Cross.svg'),
//                                   ),
//                                 ),
//                               ),
//                               const Text(
//                                 'Reason for refusal',
//                                 style: TextStyle(
//                                   fontSize: 27,
//                                   fontWeight: FontWeight.bold,
//                                   height: 1.32,
//                                 ),
//                               ),
//                               const SizedBox(height: 27),
//                               ...[
//                                 for (int i = 0; i < state.reasons!.length; i++) ...[
//                                   const SizedBox(height: 35),
//                                   ReasonBlock(
//                                     text: state.reasons![i],
//                                     index: i,
//                                   ),
//                                 ],
//                               ],
//                               const SizedBox(height: 28),
//                               GradientContainer(
//                                 isActive: state.selectedTextReason != null && state.selectedTextReason != '',
//                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
//                                 child: ActionButton(
//                                   onPressed: state.selectedTextReason != null && state.selectedTextReason != ''
//                                       ? () {
//                                           // model.deniedOffer(
//                                           //   id: offer.id,
//                                           //   reason: data.selectedTextReason!,
//                                           // );
//                                           // model.add(RemoveSelectedValuesEvent());
//                                           context.pop();
//                                         }
//                                       : null,
//                                   isActive: state.selectedTextReason != null && state.selectedTextReason != '',
//                                   text: 'Send',
//                                   backgroundColor: Colors.transparent,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const Spacer(),
//                 ],
//               ),
//             );
//           } else {
//             return const ErrorPage();
//           }
