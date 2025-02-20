import 'package:tik_dog/data/api/models/user_model.dart';
import 'package:tik_dog/domain/repositories/rating_repository.dart';

import '../../injection_container.dart';
import '../api/api_service.dart';

class RatingRepositoryImpl extends RatingRepository {
  @override
  Future<List<UserModel>> fetchRating() async {
    final apiService = getIt<ApiService>();
    final request = await apiService.fetchRating();

    return request;
  }
}
