import 'package:dio/dio.dart';
import 'package:tik_dog/domain/repositories/rating_repository.dart';

import '../../injection_container.dart';
import '../api/api_service.dart';
import '../api/models/user_rating_model.dart';

class RatingRepositoryImpl extends RatingRepository {
  @override
  Future<List<UserRatingModel>> fetchRating({CancelToken? cancelToken}) async {
    final apiService = getIt<ApiService>();
    final request = await apiService.fetchRating(cancelToken);

    return request;
  }

  @override
  Future<UserRatingModel> fetchProfileRating({CancelToken? cancelToken}) async {
    final apiService = getIt<ApiService>();
    final request = await apiService.fetchProfileRating(cancelToken);

    return request;
  }
}
