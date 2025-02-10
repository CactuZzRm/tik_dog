part of 'offers_bloc.dart';

@immutable
sealed class OffersState {}

final class OffersInitial extends OffersState {}

final class OffersCurrentOffersState extends OffersState {
  int? selectedOffersStatus = 0;
  List<OfferModel>? offers = [];
  String? selectedCountry;
  String? email;
  String? selectedReason;

  OffersCurrentOffersState({
    this.selectedOffersStatus,
    this.offers,
    this.selectedCountry,
    this.email,
    this.selectedReason,
  });

  OffersCurrentOffersState copyWith({
    List<OfferModel>? offers,
    int? selectedOffersStatus,
    String? selectedCountry,
    String? email,
    String? selectedReason,
  }) {
    return OffersCurrentOffersState(
      offers: offers ?? this.offers,
      selectedOffersStatus: selectedOffersStatus ?? this.selectedOffersStatus,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      email: email ?? this.email,
      selectedReason: selectedReason ?? this.selectedReason
    );
  }
}
