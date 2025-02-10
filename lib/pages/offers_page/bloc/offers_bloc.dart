import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tik_dog/data/repositories/offers_repository_impl.dart';

import '../../../data/api/models/accept_offer_model.dart';
import '../../../data/api/models/offer_model.dart';

part 'offers_event.dart';
part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  OffersRepositoryImpl offersRepositoryImpl;
  int selectedOffersStatus = 0;

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
  String? selectedReason;

  OffersBloc({required this.offersRepositoryImpl}) : super(OffersInitial()) {
    on<OffersInitEvent>((event, emit) async {
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>amoga');
      await fetchOffers();
      emit(OffersCurrentOffersState(offers: offers));
    });
    on<OffersChangeSelectedStatusEvent>((event, emit) {
      changeOffersStatus(event.index);
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
    on<EditReasonEvent>((event, emit) {
      selectedReason = event.reason;
      emit(OffersCurrentOffersState().copyWith(
        selectedReason: selectedReason,
      ));
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

  void changeOffersStatus(int index) {
    selectedOffersStatus = index;
  }

  Future<void> acceptOffer({
    required String id,
    required String email,
    required String country,
  }) async {
    try {
      await offersRepositoryImpl
          .acceptOffer(id: id, email: email, country: country)
          .then((response) async {});
      OffersBloc(offersRepositoryImpl: offersRepositoryImpl)
          .add(OffersInitEvent());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deniedOffer({
    required String id,
    required String reason,
  }) async {
    try {
      await offersRepositoryImpl
          .deniedOffer(id: id, reason: reason)
          .then((response) async {});
      OffersBloc(offersRepositoryImpl: offersRepositoryImpl)
          .add(OffersInitEvent());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
