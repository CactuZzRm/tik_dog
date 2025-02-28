import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tik_dog/data/repositories/offers_repository_impl.dart';

import '../../../injection_container.dart';

part 'denied_offer_details_state.dart';

class DeniedOfferDetailsCubit extends Cubit<DeniedOfferDetailsState> {
  DeniedOfferDetailsCubit() : super(DeniedOfferDetailsLoading());

  List<String>? reasons;

  void selectReasonByIndex(int index) {
    emit((state as DeniedOfferDetailsCurrent).copyWith(selectedReasonIndex: index));
  }

  void editTextReason(String textReason) {
    emit((state as DeniedOfferDetailsCurrent).copyWith(selectedTextReason: textReason));
  }

  Future<void> fetchDeniedOfferReasons() async {
    final offersRepositoryImpl = getIt<OffersRepositoryImpl>();
    try {
      final response = await offersRepositoryImpl.fetchDeniedOfferReasons();
      reasons = response;
      emit(DeniedOfferDetailsCurrent(reasons: response));
    } catch (e) {
      emit(DeniedOfferDetailsError());
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<void> deniedOffer({required String id, required String reason}) async {
    final offersRepositoryImpl = getIt<OffersRepositoryImpl>();
    try {
      await offersRepositoryImpl.deniedOffer(id: id, reason: reason).then((response) async {
        // Future.microtask(() => add(OffersInitEvent(status: status)));
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
