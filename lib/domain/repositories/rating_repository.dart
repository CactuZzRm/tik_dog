import '../../data/api/models/user_rating_model.dart';

abstract class RatingRepository {
  Future<List<UserRatingModel>> fetchRating();
  Future<UserRatingModel> fetchProfileRating();
}
