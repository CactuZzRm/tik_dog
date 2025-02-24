import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes.dart';
import '../../auth_information_page/auth_information_page.dart';
import '../bloc/offers_bloc.dart';

class OffersStatusBar extends StatelessWidget {
  const OffersStatusBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 16),
          OfferTypeContainer(text: '✨New', index: 0),
          SizedBox(width: 8),
          OfferTypeContainer(text: 'In progress', index: 1),
          SizedBox(width: 8),
          OfferTypeContainer(text: 'Completed', index: 2),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}

class OfferTypeContainer extends StatelessWidget {
  final String text;
  final int index;

  const OfferTypeContainer({
    super.key,
    required this.text,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<OffersBloc>();

    return GestureDetector(
      onTap: () => model.add(OffersChangeSelectedStatusEvent(index: index)),
      child: GradientContainer(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        needBackground: model.selectedOffersTypeStatus == index,
        decoration: BoxDecoration(
          border: index != model.selectedOffersTypeStatus
              ? Border.all(color: Theme.of(context).extension<CustomThemeData>()!.offersPageCategoryBorderColor!)
              : Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: model.selectedOffersTypeStatus == index
                    ? Colors.white
                    : Theme.of(context).extension<CustomThemeData>()!.offersPageHeaderUnselectedCategoryColor!,
              ),
        ),
      ),
    );
  }
}
