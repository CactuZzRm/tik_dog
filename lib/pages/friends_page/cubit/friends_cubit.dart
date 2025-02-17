import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_dog/data/repositories/friends_repository_impl.dart';

import '../../../data/api/models/friend_model.dart';
import '../../../injection_container.dart';

part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit() : super(FriendsInitial());

  Future<void> fetchFriends() async {
    final friendsRepositoryImpl = getIt<FriendsRepositoryImpl>();

    try {
      await friendsRepositoryImpl.fetchFriends().then((value) {
        emit(FriendsCurrentState(friends: value));
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<void> getShareFriendLink() async {
    final friendsRepositoryImpl = getIt<FriendsRepositoryImpl>();

    try {
      await friendsRepositoryImpl.getShareFriendLink().then((value) {
        Share.shareUri(Uri.parse(value.inviteUrl));
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
