import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../constants.dart';
import '../../../data/api/models/offer_model.dart';
import '../../auth_information_page/auth_information_page.dart';
import '../bloc/offers_bloc.dart';

class SelectedOfferBottomSheet extends StatelessWidget {
  final OfferModel offer;
  const SelectedOfferBottomSheet({
    required this.offer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<OffersBloc>();

    return Stack(
      children: [
        ...[
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 7.0,
              sigmaY: 7.0,
              tileMode: TileMode.clamp,
            ),
            child: const SizedBox(),
          ),
          if (AdaptiveTheme.of(context).mode.isDark)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.6 - 80,
              left: 16,
              right: 24,
              child: Image.asset('assets/images/RedTorchSelectOffer.png'),
            ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.6,
            right: 38,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset('${selectedSymbol}AcceptOfferBlurLogo.png'),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.6 + 48,
            left: 31,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset('${selectedSymbol}AcceptOfferNoBlurLogo.png'),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.6,
            right: 0,
            left: 0,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset('${selectedSymbol}AcceptOfferTopSymbol.png'),
            ),
          ),
        ],
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => context.pop(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, bottom: 12),
                        child: SvgPicture.asset('assets/icons/Cross.svg'),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 76),
                const Spacer(),
                Text(
                  'This offer is just for you',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        height: 1.33,
                      ),
                ),
                const SizedBox(height: 51),
                Text(
                  '\$${offer.formattedPrice}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color.fromRGBO(42, 255, 173, 1),
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 51),
                Text(
                  'Will you accept this offer?',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                ),
                const Spacer(),
                GradientContainer(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ActionButton(
                    onPressed: () {
                      context.pushNamed('AcceptOfferDetailsPage', extra: offer);
                      context.pop();
                    },
                    text: 'Accept',
                    backgroundColor: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 16),
                ActionButton(
                  onPressed: () {
                    context.pop();
                    context.pushNamed('DeniedOfferDetailsPage', extra: offer);
                    // try {
                    //   await model.fetchDeniedOfferReasons().then((value) {
                    //     if (context.mounted) {

                    //     }
                    //   });
                    // } catch (e) {
                    //   debugPrint(e.toString());
                    //   throw Exception(e);
                    // }
                  },
                  text: 'Not now',
                  backgroundColor: Theme.of(context).cardColor,
                  margin: const EdgeInsets.symmetric(horizontal: 17),
                ),
                const SizedBox(height: 21),
              ],
            ),
          ),
        ),
        ...[
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.6 - 81 / 2,
            left: 0,
            right: 0,
            child: Container(
              height: 81,
              width: 81,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).highlightColor,
              ),
              child: const Center(
                  child: Text('🥳', textAlign: TextAlign.center, style: TextStyle(fontSize: 40, height: 1.2))),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.6 - 50 / 2 - MediaQuery.of(context).padding.top,
            left: 81,
            child: Image.asset(
              '${selectedSymbol}LogoRightNotFilter.png',
            ),
          ),
        ],
      ],
    );
  }
}
