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

class EditTextReasonEvent extends OffersEvent {
  final String textReason;

  EditTextReasonEvent({required this.textReason});
}

class SelectCountReasonEvent extends OffersEvent {
  final int index;

  SelectCountReasonEvent({required this.index});
}

class RemoveSelectedValuesEvent extends OffersEvent {}
