import '../../data/api/models/friend_model.dart';

abstract class FriendsRepository {
  Future<List<FriendModel>> fetchFriends();
}
