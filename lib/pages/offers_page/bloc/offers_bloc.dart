import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tik_dog/data/repositories/offers_repository_impl.dart';

import '../../../data/api/models/offer_model.dart';

part 'offers_event.dart';
part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
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
  String? selectedTextReason;
  int? selectedReasonIndex;
  List<String>? reasons;

  OffersBloc({required this.offersRepositoryImpl}) : super(OffersInitial()) {
    on<OffersInitEvent>((event, emit) async {
      await fetchOffers();
      emit(OffersCurrentOffersState(offers: offers));
    });
    on<OffersChangeSelectedStatusEvent>((event, emit) {
      changeOffersTypeStatus(event.index);
      emit(OffersCurrentOffersState().copyWith(
        selectedOffersStatus: event.index,
      ));
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
  }

  List<OfferModel> offers = [];

  Future<void> fetchOffers() async {
    try {
      await offersRepositoryImpl.getOffers().then((response) {
        offers = response;
      });
    } catch (e) {
      debugPrint(e.toString());
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
      await offersRepositoryImpl.acceptOffer(id: id, email: email, country: country).then((response) async {
        Future.microtask(() => add(OffersInitEvent()));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deniedOffer({
    required String id,
    required String reason,
  }) async {
    try {
      await offersRepositoryImpl.deniedOffer(id: id, reason: reason).then((response) async {
        Future.microtask(() => add(OffersInitEvent()));
      });
    } catch (e) {
      debugPrint(e.toString());
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
