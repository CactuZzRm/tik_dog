part of 'denied_offer_details_cubit.dart';

@immutable
sealed class DeniedOfferDetailsState {}

final class DeniedOfferDetailsInitial extends DeniedOfferDetailsState {}

final class DeniedOfferDetailsLoading extends DeniedOfferDetailsState {}

final class DeniedOfferDetailsCurrent extends DeniedOfferDetailsState {
  final List<String>? reasons;
  final String? selectedTextReason;
  final int? selectedReasonIndex;

  DeniedOfferDetailsCurrent({this.reasons, this.selectedTextReason, this.selectedReasonIndex});

  DeniedOfferDetailsCurrent copyWith({
    List<String>? reasons,
    String? selectedTextReason,
    int? selectedReasonIndex,
  }) {
    return DeniedOfferDetailsCurrent(
      reasons: reasons ?? this.reasons,
      selectedTextReason: selectedTextReason ?? this.selectedTextReason,
      selectedReasonIndex: selectedReasonIndex ?? this.selectedReasonIndex,
    );
  }
}

final class DeniedOfferDetailsError extends DeniedOfferDetailsState {}
