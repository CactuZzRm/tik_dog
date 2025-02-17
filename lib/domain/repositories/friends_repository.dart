import 'package:tik_dog/data/api/response_models/share_friend_link_response.dart';

import '../../data/api/models/friend_model.dart';

abstract class FriendsRepository {
  Future<List<FriendModel>> fetchFriends();
  Future<ShareFriendLinkResponse> getShareFriendLink();
}
