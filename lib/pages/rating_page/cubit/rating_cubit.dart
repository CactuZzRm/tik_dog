import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/api/models/user_model.dart';
import '../../../data/repositories/rating_repository_impl.dart';
import '../../../injection_container.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingLoadingState());

  Future<void> fetchRating() async {
    final ratingRepository = getIt<RatingRepositoryImpl>();

    await ratingRepository.fetchRating().then((rating) {
      emit(RatingCurrentState(rating: rating + rating + rating + rating + rating + rating + rating + rating));
    }).catchError((e) {
      debugPrint(e.toString());
      throw Exception(e);
    });
  }
}
