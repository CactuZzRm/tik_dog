part of 'offers_bloc.dart';

@immutable
sealed class OffersEvent {}

class OffersInitEvent extends OffersEvent {}

class OffersChangeSelectedStatusEvent extends OffersEvent {
  final int index;

  OffersChangeSelectedStatusEvent({required this.index});
}

class SelectCountryEvent extends OffersEvent {
  final String country;

  SelectCountryEvent({required this.country});
}

class EditReasonEvent extends OffersEvent {
  final String reason;

  EditReasonEvent({required this.reason});
}
