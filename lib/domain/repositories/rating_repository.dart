import 'package:dio/dio.dart';

import '../../data/api/models/user_rating_model.dart';

abstract class RatingRepository {
  Future<List<UserRatingModel>> fetchRating({CancelToken? cancelToken});
  Future<UserRatingModel> fetchProfileRating({CancelToken? cancelToken});
}
