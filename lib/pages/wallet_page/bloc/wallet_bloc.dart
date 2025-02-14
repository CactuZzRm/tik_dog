import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tik_dog/data/api/response_models/change_social_network_response.dart';
import 'package:tik_dog/data/repositories/auth_repository_impl.dart';

import '../../../data/api/models/user_model.dart';
import '../../../injection_container.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<WalletEvent>((event, emit) {});
    on<WalletInitEvent>((event, emit) {
      final user = event.userModel;
      emit(WalletCurrentState(user: user));
    });
    on<ChangeUserEvent>((event, emit) async {
      await changeSocialNetwork();
      emit(WalletCurrentState(user: user));
    });
  }

  late UserModel user;

  Future<void> changeSocialNetwork() async {
    final authRepositoryImpl = getIt<AuthRepositoryImpl>();

    try {
      await authRepositoryImpl.changeSocialNetwork().then((response) {
        user = response;
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
