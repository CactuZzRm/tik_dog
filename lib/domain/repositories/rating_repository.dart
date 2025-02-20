import '../../data/api/models/user_model.dart';

abstract class RatingRepository {
  Future<List<UserModel>> fetchRating();
}
