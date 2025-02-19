import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tik_dog/data/repositories/auth_repository_impl.dart';

import '../../../data/api/models/user_model.dart';
import '../../../injection_container.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletLoadingState()) {
    on<WalletEvent>((event, emit) {});
    on<WalletInitEvent>((event, emit) {
      final user = event.userModel;
      emit(WalletCurrentState(user: user));
    });
    on<ChangeUserEvent>((event, emit) async {
      await changeSocialNetwork();
      emit(WalletCurrentState(user: user));
    });
    screenshotController = ScreenshotController();
  }

  late UserModel user;
  late final ScreenshotController screenshotController;

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

  Future<void> getScreen() async {
    try {
      final screen = await screenshotController.capture();

      final Directory tempDir = await getTemporaryDirectory();
      final File file = File('${tempDir.path}/screenshot.png');
      await file.writeAsBytes(screen!);

      await Share.shareXFiles([XFile(file.path)], text: 'Who let the DOGS out?');
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
