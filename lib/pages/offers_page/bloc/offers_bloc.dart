import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tik_dog/data/repositories/offers_repository_impl.dart';

import '../../../data/api/models/offer_model.dart';

part 'offers_event.dart';
part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  OffersBloc({required this.offersRepositoryImpl}) : super(OffersInitial()) {
    on<OffersInitEvent>((event, emit) async {
      final status = event.status ?? getOffersStatus;
      final limit = selectedOffersTypeStatus == 0 ? 1 : null;

      await fetchOffers(limit: limit, status: status);
      emit(OffersCurrentOffersState(offers: offers));
    });
    on<OffersChangeSelectedStatusEvent>((event, emit) async {
      changeOffersTypeStatus(event.index);
      final limit = selectedOffersTypeStatus == 0 ? 1 : null;
      await fetchOffers(limit: limit, status: getOffersStatus);
      emit(OffersCurrentOffersState().copyWith(
        offers: offers,
        selectedOffersStatus: event.index,
      ));
    });
    on<AcceptOfferEvent>((event, emit) async {
      await acceptOffer(id: event.id, email: event.email, country: event.country);
    });
    on<DeniedOfferEvent>((event, emit) async {
      await deniedOffer(id: event.id, reason: event.reason);
    });
    on<SelectCountryEvent>((event, emit) {
      selectedCountry = event.country;
      emit(OffersCurrentOffersState().copyWith(
        selectedCountry: selectedCountry,
      ));
    });
    on<EditTextReasonEvent>((event, emit) {
      selectedTextReason = event.textReason;
      emit(OffersCurrentOffersState().copyWith(
        selectedTextReason: selectedTextReason,
      ));
    });
    on<SelectCountReasonEvent>((event, emit) {
      selectedReasonIndex = event.index;
      emit(OffersCurrentOffersState().copyWith());
    });
    on<RemoveSelectedValuesEvent>((event, emit) {
      selectedCountry = null;
      selectedTextReason = null;
      selectedReasonIndex = null;
      emit(OffersCurrentOffersState().copyWith());
    });
  }

  OffersRepositoryImpl offersRepositoryImpl;
  int selectedOffersTypeStatus = 0;

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  String? selectedCountry;

  List<String>? reasons;
  String? selectedTextReason;
  int? selectedReasonIndex;

  List<OfferModel> offers = [];
  String? get getOffersStatus => selectedOffersTypeStatus == 0
      ? null
      : selectedOffersTypeStatus == 1
          ? 'accepted'
          : 'declined';

  Future<void> fetchOffers({int? limit, String? status}) async {
    try {
      await offersRepositoryImpl.getOffers(limit: limit, status: status).then((response) {
        offers = response;
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  void changeOffersTypeStatus(int index) {
    selectedOffersTypeStatus = index;
  }

  Future<void> acceptOffer({
    required String id,
    required String email,
    required String country,
  }) async {
    try {
      final status = getOffersStatus;
      await offersRepositoryImpl.acceptOffer(id: id, email: email, country: country).then((response) async {
        Future.microtask(() => add(OffersInitEvent(status: status)));
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<void> deniedOffer({
    required String id,
    required String reason,
  }) async {
    try {
      final status = getOffersStatus;
      await offersRepositoryImpl.deniedOffer(id: id, reason: reason).then((response) async {
        Future.microtask(() => add(OffersInitEvent(status: status)));
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<void> fetchDeniedOfferReasons() async {
    try {
      final response = await offersRepositoryImpl.fetchDeniedOfferReasons();
      reasons = response;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
