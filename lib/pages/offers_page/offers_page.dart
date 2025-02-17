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
          model.add(OffersInitEvent(status: null));
        } else if (state is OffersCurrentOffersState) {
          List<OfferModel>? offers;
          if (context.watch<OffersBloc>().offers.isNotEmpty) {
            offers = context.watch<OffersBloc>().offers;
          }

          return Scaffold(
            body: Column(
              children: [
                const SizedBox(height: 22),
                const OffersStatusBar(),
                const SizedBox(height: 28),
                if (offers != null && offers.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: offers.length,
                      itemBuilder: (context, index) {
                        return OfferCard(
                          offer: offers![index],
                          image: 'assets/images/Offer.png',
                          onTap: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            useRootNavigator: true,
                            builder: (context) => const SelectedOfferBottomSheet(),
                          ),
                        );
                      },
                    ),
                  )
                else
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 28),
                      width: double.infinity,
                      child: Text(
                        'New offers will appear here soon',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 1.33,
                            ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }
        return const Center(child: Text('Загрузка'));
      },
    );
  }
}
