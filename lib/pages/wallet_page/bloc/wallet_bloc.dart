import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_dog/constants.dart';
import 'package:tik_dog/data/repositories/auth_repository_impl.dart';
import 'package:tik_dog/data/repositories/wallet_repository_impl.dart';

import '../../../data/api/models/group_user_model.dart';
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
    on<GroupUserById>((event, emit) async {
      if (user.userGroupId != null) return;

      final walletRepositoryImpl = getIt<WalletRepositoryImpl>();

      final tiktokId = getIt<SharedPreferences>().getString('tiktok_id');
      final instagramId = getIt<SharedPreferences>().getString('instagram_id');

      if (tiktokId != null && !isTikTokSelect) {
        final body = GroupUserBody(userId: tiktokId);
        await walletRepositoryImpl.groupUser(body);
      } else if (instagramId != null && isTikTokSelect) {
        final body = GroupUserBody(userId: instagramId);
        await walletRepositoryImpl.groupUser(body);
      }
    });
    on<GetUserData>((event, emit) async {
      if (event.needChangeSocialNetwork) isTikTok = !isTikTok;
      await getUserData();
      emit(WalletCurrentState(user: user));
    });
    on<SaveUserId>((event, emit) async {
      if (isTikTokSelect) {
        await getIt<SharedPreferences>().setString('tiktok_id', user.id);
      } else {
        await getIt<SharedPreferences>().setString('instagram_id', user.id);
      }
    });
    screenshotController = ScreenshotController();
  }

  late UserModel user;
  late final ScreenshotController screenshotController;

  late bool isTikTok;

  bool get isTikTokSelect => user.provider == 'tiktok' ? true : false;

  CancelToken cancelToken = CancelToken();

  bool changeTokenFromCache(SocialNetworks socialNetwork, BuildContext context) {
    final socialNetworkToString = socialNetwork.name;

    if (getIt<SharedPreferences>().getString('${socialNetworkToString}_token') != null) {
      final cacheToken = getIt<SharedPreferences>().getString('${socialNetworkToString}_token');
      getIt<Dio>().interceptors.add(
            InterceptorsWrapper(
              onRequest: (options, handler) async {
                final token = cacheToken; // Получаем токен
                if (token != null) {
                  options.headers['Authorization'] = 'Bearer $token';
                }
                handler.next(options);
              },
              onResponse: (response, handler) {
                handler.next(response);
              },
            ),
          );
      Future.microtask(() => add(GetUserData(needChangeSocialNetwork: true))).then((value) {
        if (context.mounted) {
          selectedSymbol =
              socialNetworkToString == 'tiktok' ? 'assets/images/TikTokSymbol' : 'assets/images/InstagramSymbol';
          socialNetworkToString == 'tiktok'
              ? AdaptiveTheme.of(context).setDark()
              : AdaptiveTheme.of(context).setLight();
        }
      });
      return true;
    } else {
      return false;
    }
  }

  Future<void> getUserData() async {
    cancelToken.cancel('--- CANCEL fetch me REQUEST ---');
    cancelToken = CancelToken();

    final authRepositoryImpl = getIt<AuthRepositoryImpl>();

    try {
      await authRepositoryImpl.getUserData(cancelToken: cancelToken).then((response) {
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
