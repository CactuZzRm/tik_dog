part of 'rating_cubit.dart';

@immutable
sealed class RatingState {}

final class RatingInitial extends RatingState {}

final class RatingLoadingState extends RatingState {}

final class RatingCurrentState extends RatingState {
  final UserRatingModel profileRating;
  final List<UserRatingModel> rating;

  RatingCurrentState({required this.profileRating, required this.rating});
}
