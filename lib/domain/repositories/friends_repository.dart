import 'package:dio/dio.dart';
import 'package:tik_dog/data/api/response_models/share_friend_link_response.dart';

import '../../data/api/models/user_model.dart';

abstract class FriendsRepository {
  Future<List<UserModel>> fetchFriends({CancelToken? cancelToken});
  Future<ShareFriendLinkResponse> getShareFriendLink();
}
