import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_dog/data/repositories/friends_repository_impl.dart';

import '../../../data/api/models/user_model.dart';
import '../../../injection_container.dart';

part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit() : super(FriendsInitial());

  CancelToken cancelToken = CancelToken();

  void makeInit() {
    emit(FriendsInitial());
  }

  Future<void> fetchFriends() async {
    final friendsRepositoryImpl = getIt<FriendsRepositoryImpl>();

    emit(FriendsLoadingState());
    cancelToken.cancel('--- CANCEL fetch friends REQUEST ---');
    cancelToken = CancelToken();
    try {
      await friendsRepositoryImpl.fetchFriends(cancelToken: cancelToken).then((value) {
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
