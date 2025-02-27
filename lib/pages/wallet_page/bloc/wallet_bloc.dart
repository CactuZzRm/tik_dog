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
    // on<ChangeTokenEvent>((event, emit) {
    //   changeToken(event.socialNetwork);
    // });
    on<GetUserData>((event, emit) async {
      await getUserData();
      emit(WalletCurrentState(user: user));
    });
    screenshotController = ScreenshotController();
  }

  late UserModel user;
  late final ScreenshotController screenshotController;

  bool get isTikTokSelect => user.provider == 'tiktok' ? true : false;

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
      Future.microtask(() => add(GetUserData())).then((value) {
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
      print(getIt<SharedPreferences>().getString('tiktok_token'));
      print(getIt<SharedPreferences>().getString('instagram_token'));
      print('not found');
      return false;
    }
  }

  Future<void> getUserData() async {
    final authRepositoryImpl = getIt<AuthRepositoryImpl>();

    try {
      await authRepositoryImpl.getUserData().then((response) {
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

// class SocialNetworkChangeEvent extends AuthEvent {
//   final BuildContext themeContext;
//   final bool isTikTok;

//   SocialNetworkChangeEvent({required this.themeContext, required this.isTikTok});
// }

//  on<SocialNetworkChangeEvent>((event, emit) async {
//       final selectedSocialNetwork = event.isTikTok ? 'tiktok' : 'instagram';

//       if (event.isTikTok == true && getIt<SharedPreferences>().getString('tiktok_token') != null) {
//         final newToken = getIt<SharedPreferences>().getString('tiktok_token');
//         getIt<Dio>().interceptors.add(
//               InterceptorsWrapper(
//                 onRequest: (options, handler) async {
//                   if (newToken != null) {
//                     options.headers['Authorization'] = 'Bearer $newToken';
//                   }
//                   handler.next(options);
//                 },
//                 onResponse: (response, handler) {
//                   handler.next(response);
//                 },
//               ),
//             );
//         isTikTok = event.isTikTok;
//         isTikTok ? AdaptiveTheme.of(event.themeContext).setDark() : AdaptiveTheme.of(event.themeContext).setLight();
//         selectedSymbol = isTikTok ? 'assets/images/TikTokSymbol' : 'assets/images/InstagramSymbol';
//       } else if (event.isTikTok == false && getIt<SharedPreferences>().getString('instagram_token') != null) {
//         final newToken = getIt<SharedPreferences>().getString('instagram_token');
//         getIt<Dio>().interceptors.add(
//               InterceptorsWrapper(
//                 onRequest: (options, handler) async {
//                   if (newToken != null) {
//                     options.headers['Authorization'] = 'Bearer $newToken';
//                   }
//                   handler.next(options);
//                 },
//                 onResponse: (response, handler) {
//                   handler.next(response);
//                 },
//               ),
//             );
//         isTikTok = event.isTikTok;
//         isTikTok ? AdaptiveTheme.of(event.themeContext).setDark() : AdaptiveTheme.of(event.themeContext).setLight();
//         selectedSymbol = isTikTok ? 'assets/images/TikTokSymbol' : 'assets/images/InstagramSymbol';
//       } else {
//         isTikTok = event.isTikTok;
//         await getTempToken(selectedSocialNetwork);
//       }
//     });
