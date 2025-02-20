part of 'rating_cubit.dart';

@immutable
sealed class RatingState {}

final class RatingInitial extends RatingState {}

final class RatingLoadingState extends RatingState {}

final class RatingCurrentState extends RatingState {
  final List<UserModel> rating;

  RatingCurrentState({required this.rating});
}
