import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/api/models/offer_model.dart';
import 'bloc/offers_bloc.dart';
import 'components/offer_card.dart';
import 'components/offers_status_bar.dart';
import 'components/selected_offer_bottom_sheet.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersBloc, OffersState>(
      builder: (context, state) {
        final model = context.watch<OffersBloc>();

        if (state is OffersInitial) {
          model.add(OffersInitEvent());
        } else if (state is OffersCurrentOffersState) {
          OfferModel? offer;
          if (context.watch<OffersBloc>().offers.isNotEmpty) {
            offer = context.watch<OffersBloc>().offers[0];
          }

          return Scaffold(
            body: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                const SizedBox(height: 22),
                OffersStatusBar(),
                const SizedBox(height: 28),
                if (offer != null)
                  OfferCard(
                    text: offer.title,
                    image: 'assets/images/Offer.png',
                    price: offer.formattedPrice.toString(),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      useRootNavigator: true,
                      builder: (context) => SelectedOfferBottomSheet(),
                    ),
                  ),
              ],
            ),
          );
        }
        return Center(child: Text('Загрузка'));
      },
    );
  }
}
