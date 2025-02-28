import 'package:tik_dog/data/api/models/group_user_model.dart';
import 'package:tik_dog/domain/repositories/wallet_repository.dart';

import '../../injection_container.dart';
import '../api/api_service.dart';

class WalletRepositoryImpl extends WalletRepository {
  @override
  Future<void> groupUser(GroupUserBody body) async {
    final apiSerivce = getIt<ApiService>();

    await apiSerivce.groupUser(body);
  }
}
