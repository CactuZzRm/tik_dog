import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tik_dog/data/repositories/offers_repository_impl.dart';
import 'package:tik_dog/domain/extensions/email_validator_string_extension.dart';

import '../../../data/api/models/offer_model.dart';

part 'offers_event.dart';
part 'offers_state.dart';

class OffersBloc extends Bloc<OffersEvent, OffersState> {
  OffersBloc({required this.offersRepositoryImpl}) : super(OffersInitial()) {
    on<OffersInitEvent>((event, emit) async {
      emit(OffersLoadingState());
      final status = event.status ?? getOffersStatus;
      final limit = selectedOffersTypeStatus == 0 ? 1 : null;

      await fetchOffers(limit: limit, status: status);
      emit(OffersCurrentOffersState(offers: offers));
    });
    on<RefreshOffersEvent>((event, emit) async {
      emit(OffersLoadingState());
      final status = getOffersStatus;
      final limit = selectedOffersTypeStatus == 0 ? 1 : null;

      await fetchOffers(limit: limit, status: status);
      emit(OffersCurrentOffersState(offers: offers));
    });
    on<OffersChangeSelectedStatusEvent>((event, emit) async {
      if (event.index != selectedOffersTypeStatus) {
        changeOffersTypeStatus(event.index);
        emit(OffersCurrentOffersState().copyWith(
          offers: null,
          selectedOffersStatus: event.index,
        ));
      }
    });
    on<AcceptOfferEvent>((event, emit) async {
      await acceptOffer(id: event.id, email: event.email, country: event.country);
    });
    on<SelectCountryEvent>((event, emit) {
      selectedCountry = event.country;
      emit((state as OffersCurrentOffersState).copyWith(
        selectedCountry: selectedCountry,
      ));
    });
    on<RemoveSelectedValuesEvent>((event, emit) {
      selectedCountry = null;

      selectedReasonIndex = null;
      emit((state as OffersCurrentOffersState).copyWith());
    });
    on<EditEMailTextEvent>((event, emit) {
      checkMail(event.text);
    });
  }

  late int offersPrice;

  OffersRepositoryImpl offersRepositoryImpl;
  int selectedOffersTypeStatus = 0;

  String? selectedCountry;

  int? selectedReasonIndex;

  bool validMail = false;

  CancelToken cancelToken = CancelToken();

  List<OfferModel>? offers = [];
  String? get getOffersStatus => selectedOffersTypeStatus == 0
      ? null
      : selectedOffersTypeStatus == 1
          ? 'accepted'
          : 'declined';

  Future<void> fetchOffers({int? limit, String? status}) async {
    cancelToken.cancel('--- CANCEL fetch offers REQUEST ---');
    cancelToken = CancelToken();
    try {
      await offersRepositoryImpl.getOffers(limit: limit, status: status, cancelToken: cancelToken).then((response) {
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

  bool checkMail(String? value) {
    validMail = value != null && value.isValidEmail();
    return validMail;
  }

  void makeInit() {
    emit(OffersInitial());
  }
}
