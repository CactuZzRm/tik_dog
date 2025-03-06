import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/api/models/offer_model.dart';
import '../../wallet_page/bloc/wallet_bloc.dart';
import '../bloc/offers_bloc.dart';
import 'selected_offer_bottom_sheet.dart';

class OfferCard extends StatelessWidget {
  final OfferModel offer;

  const OfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    final offerPriceFromWalletModel = context.read<WalletBloc>().user.offerPrice;

    return GestureDetector(
      onTap: context.watch<OffersBloc>().selectedOffersTypeStatus != 0
          ? () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                useRootNavigator: true,
                builder: (context) => SelectedOfferBottomSheet(offer: offer),
              )
          : () {},
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                offer.picture == null
                    ? SizedBox(
                        height: 216,
                        width: double.infinity,
                        child: SvgPicture.asset('assets/icons/BIGpie.svg', fit: BoxFit.none),
                      )
                    : Image.network(
                        offer.picture!,
                        height: 216,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 216,
                            decoration: BoxDecoration(
                              color: AdaptiveTheme.of(context).mode.isDark
                                  ? const Color.fromRGBO(23, 23, 23, 1)
                                  : const Color.fromRGBO(233, 233, 233, 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              // child: Text('Image error'),
                              child: SvgPicture.asset('assets/icons/BIGpie.svg'),
                            ),
                          );
                        },
                      ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
                      borderRadius: BorderRadius.circular(36),
                    ),
                    child: Text(
                      '\$$offerPriceFromWalletModel',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 24,
                            color: const Color.fromRGBO(42, 255, 173, 1),
                            fontWeight: FontWeight.bold,
                            height: 1.21,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              offer.title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.33,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
