import 'package:tik_dog/data/api/models/user_model.dart';
import 'package:tik_dog/domain/repositories/rating_repository.dart';

import '../../injection_container.dart';
import '../api/api_service.dart';
import '../api/models/user_rating_model.dart';

class RatingRepositoryImpl extends RatingRepository {
  @override
  Future<List<UserRatingModel>> fetchRating() async {
    final apiService = getIt<ApiService>();
    final request = await apiService.fetchRating();

    return request;
  }
  
  @override
  Future<UserRatingModel> fetchProfileRating() async {
    final apiService = getIt<ApiService>();
    final request = await apiService.fetchProfileRating();

    return request;
  }
}
