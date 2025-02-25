part of 'offers_bloc.dart';

@immutable
sealed class OffersEvent {}

class OffersInitEvent extends OffersEvent {
  final String? status;

  OffersInitEvent({this.status});
}

class RefreshOffersEvent extends OffersEvent {}

class OffersChangeSelectedStatusEvent extends OffersEvent {
  final int index;

  OffersChangeSelectedStatusEvent({required this.index});
}

class AcceptOfferEvent extends OffersEvent {
  final String id;
  final String email;
  final String country;

  AcceptOfferEvent({required this.id, required this.email, required this.country});
}

class DeniedOfferEvent extends OffersEvent {
  final String id;
  final String reason;

  DeniedOfferEvent({required this.id, required this.reason});
}

class SelectCountryEvent extends OffersEvent {
  final String country;

  SelectCountryEvent({required this.country});
}

class EditTextReasonEvent extends OffersEvent {
  final String textReason;

  EditTextReasonEvent({required this.textReason});
}

class SelectCountReasonEvent extends OffersEvent {
  final int index;

  SelectCountReasonEvent({required this.index});
}

class RemoveSelectedValuesEvent extends OffersEvent {}
