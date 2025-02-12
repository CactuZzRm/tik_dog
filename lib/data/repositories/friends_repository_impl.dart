import 'package:tik_dog/data/api/models/friend_model.dart';

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
}
