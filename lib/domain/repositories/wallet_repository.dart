import 'package:tik_dog/data/api/models/group_user_model.dart';

abstract class WalletRepository {
  Future<void> groupUser(GroupUserBody body);
}
