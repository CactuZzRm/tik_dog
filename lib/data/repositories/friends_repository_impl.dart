import 'package:tik_dog/data/api/models/friend_model.dart';
import 'package:tik_dog/data/api/response_models/share_friend_link_response.dart';

import '../../domain/repositories/friends_repository.dart';
import '../../injection_container.dart';
import '../api/api_service.dart';

class FriendsRepositoryImpl extends FriendsRepository {
  @override
  Future<List<FriendModel>> fetchFriends() async {
    final apiService = getIt<ApiService>();
    final request = await apiService.fetchFriends();

    return request;
  }

  @override
  Future<ShareFriendLinkResponse> getShareFriendLink() async {
    final apiService = getIt<ApiService>();
    final request = await apiService.getShareFriendLink();

    return request;
  }
}
