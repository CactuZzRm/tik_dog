part of 'offers_bloc.dart';

@immutable
sealed class OffersEvent {}

class OffersInitEvent extends OffersEvent {
  final String? status;

  OffersInitEvent({this.status});
}

class RefreshOffersEvent extends OffersEvent {
  final int? index;

  RefreshOffersEvent({this.index});
}

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

class SelectCountryEvent extends OffersEvent {
  final String country;

  SelectCountryEvent({required this.country});
}

class EditEMailTextEvent extends OffersEvent {
  final String text;

  EditEMailTextEvent({required this.text});
}

class RemoveSelectedValuesEvent extends OffersEvent {}
