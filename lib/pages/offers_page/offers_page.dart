import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_dog/pages/auth_loading_page/auth_loading_page.dart';

import '../../data/api/models/offer_model.dart';
import '../error_page/error_page.dart';
import 'bloc/offers_bloc.dart';
import 'components/offer_card.dart';
import 'components/offers_status_bar.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 22),
          const OffersStatusBar(),
          const SizedBox(height: 28),
          BlocBuilder<OffersBloc, OffersState>(
            builder: (context, state) {
              final model = context.watch<OffersBloc>();

              if (state is OffersInitial) {
                model.add(OffersInitEvent(status: null));
                return const Expanded(child: Center(child: AnimatedHorizontalSteps()));
              } else if (state is OffersLoadingState) {
                return const Expanded(child: Center(child: AnimatedHorizontalSteps()));
              } else if (state is OffersCurrentOffersState) {
                List<OfferModel>? offers;
                offers = state.offers;

                if (offers != null && offers.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: offers.length,
                      itemBuilder: (context, index) {
                        return OfferCard(offer: offers![index]);
                      },
                    ),
                  );
                } else if (offers != null && offers.isEmpty && model.selectedOffersTypeStatus != 2) {
                  return Expanded(
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
                  );
                } else {
                  return const SizedBox();
                }
              }
              return const ErrorPage();
            },
          ),
        ],
      ),
    );
  }
}
