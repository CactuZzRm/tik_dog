import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/api/models/user_rating_model.dart';
import '../../../data/repositories/rating_repository_impl.dart';
import '../../../injection_container.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingLoadingState());

  Future<void> fetchRating() async {
    final ratingRepository = getIt<RatingRepositoryImpl>();
    try {
      late UserRatingModel profileRating;
      late List<UserRatingModel> rating;

      await ratingRepository.fetchRating().then((ratingData) {
        rating = ratingData;
      }).catchError((e) {
        debugPrint(e.toString());
        throw Exception(e);
      });

      await ratingRepository.fetchProfileRating().then((ratingData) {
        profileRating = ratingData;
      }).catchError((e) {
        debugPrint(e.toString());
        throw Exception(e);
      });

      emit(RatingCurrentState(profileRating: profileRating, rating: rating));
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
