import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../constants.dart';
import '../../auth_information_page/auth_information_page.dart';
import '../bloc/offers_bloc.dart';

class SelectedOfferBottomSheet extends StatelessWidget {
  const SelectedOfferBottomSheet({
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
            child: SizedBox(),
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
            left: 31,
            right: AdaptiveTheme.of(context).mode.isDark ? 36 : 38,
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset('${selectedSymbol}AcceptOfferTopImage.png'),
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
              borderRadius: BorderRadius.only(
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
                    child: InkWell(
                      onTap: () => context.pop(),
                      child: SvgPicture.asset('assets/icons/Cross.svg'),
                    ),
                  ),
                ),
                // SizedBox(height: 76),
                Spacer(),
                Text(
                  'This offer is just for you',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        height: 1.33,
                      ),
                ),
                SizedBox(height: 51),
                Text(
                  //TODO: Какая нужна цена и нужен ли символ валюты
                  model.offers[0].formattedPrice,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color.fromRGBO(42, 255, 173, 1),
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 51),
                Text(
                  'Will you accept this offer?',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                ),
                Spacer(),
                GradientContainer(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ActionButton(
                    onPressed: () =>
                        context.pushNamed('AcceptOfferDetailsPage'),
                    text: 'Accept',
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(height: 16),
                ActionButton(
                  onPressed: () => context.pushNamed('DeniedOfferDetailsPage'),
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
            bottom: MediaQuery.of(context).size.height * 0.6 -
                81 / 2 -
                MediaQuery.of(context).padding.top,
            left: MediaQuery.of(context).size.width / 2 - 81 / 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).highlightColor,
              ),
              child: Text('🥳', style: TextStyle(fontSize: 40)),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.6 -
                50 / 2 -
                MediaQuery.of(context).padding.top,
            left: MediaQuery.of(context).size.width / 2 - 50 / 2 - 80,
            child: Image.asset(
              '${selectedSymbol}LogoRightNotFilter.png',
            ),
          ),
        ],
      ],
    );
  }
}
