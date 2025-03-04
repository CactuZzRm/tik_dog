import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../data/api/models/user_rating_model.dart';
import '../../../data/repositories/rating_repository_impl.dart';
import '../../../injection_container.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingInitial());

  CancelToken cancelToken = CancelToken();

  void makeInit() {
    emit(RatingInitial());
  }

  Future<void> fetchRating() async {
    cancelToken.cancel('--- CANCEL fetch rating REQUEST ---');
    cancelToken = CancelToken();

    final ratingRepository = getIt<RatingRepositoryImpl>();
    emit(RatingLoadingState());
    try {
      late UserRatingModel profileRating;
      late List<UserRatingModel> rating;

      await ratingRepository.fetchRating(cancelToken: cancelToken).then((ratingData) {
        rating = ratingData;
      }).catchError((e) {
        debugPrint(e.toString());
        throw Exception(e);
      });

      await ratingRepository.fetchProfileRating(cancelToken: cancelToken).then((ratingData) {
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
