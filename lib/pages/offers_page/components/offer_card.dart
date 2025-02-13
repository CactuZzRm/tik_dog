import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/api/models/offer_model.dart';
import '../bloc/offers_bloc.dart';

class OfferCard extends StatelessWidget {
  final OfferModel offer;
  final Function() onTap;
  final String image;

  const OfferCard({
    super.key,
    required this.offer,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.watch<OffersBloc>().selectedOffersTypeStatus == 0 ? onTap : () {},
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(image, width: double.infinity, fit: BoxFit.cover),
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
                      offer.formattedPrice,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 24,
                            color: Color.fromRGBO(42, 255, 173, 1),
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
