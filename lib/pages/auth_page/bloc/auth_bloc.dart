import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_dog/data/api/models/exchange_temp_token_model.dart';
import 'package:tik_dog/data/repositories/auth_repository_impl.dart';

import '../../../constants.dart';
import '../../../data/api/models/user_model.dart';
import '../../../injection_container.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl authRepositoryImpl;
  String tempToken = '';
  String loginUrl = '';
  String? token = '';
  late bool isTikTok;
  String? inviteKey;

  String groupKey = '';

  AuthBloc({required this.authRepositoryImpl}) : super(AuthLoading()) {
    on<AuthLoadingEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        emit(AuthCurrentState());
      });
    });
    on<AuthLoginEvent>((event, emit) async {
      final selectedSocialNetwork = event.socialNetwork == SocialNetworks.tiktok ? 'tiktok' : 'instagram';
      isTikTok = event.socialNetwork == SocialNetworks.tiktok ? true : false;
      isTikTok ? AdaptiveTheme.of(event.themeContext).setDark() : AdaptiveTheme.of(event.themeContext).setLight();
      selectedSymbol = isTikTok ? 'assets/images/TikTokSymbol' : 'assets/images/InstagramSymbol';

      if (event.socialNetwork == SocialNetworks.tiktok &&
          getIt<SharedPreferences>().getString('tiktok_token') != null) {
      } else if (event.socialNetwork == SocialNetworks.instagram &&
          getIt<SharedPreferences>().getString('instagram_token') != null) {
      } else {
        await getTempToken(selectedSocialNetwork);
      }
    });
    on<SocialNetworkChangeEvent>((event, emit) async {
      isTikTok = event.isTikTok;
      isTikTok ? AdaptiveTheme.of(event.themeContext).setDark() : AdaptiveTheme.of(event.themeContext).setLight();
      selectedSymbol = isTikTok ? 'assets/images/TikTokSymbol' : 'assets/images/InstagramSymbol';
    });
    on<GetKeyEvent>((event, emit) async {
      await getKey();
      emit(AuthCurrentState().copyWith());
    });
    on<SetKeyEvent>((event, emit) async {
      await setKey(event.key);
    });
  }

  Future<void> getTempToken(String provider) async {
    try {
      await authRepositoryImpl.getUrl(provider, inviteKey).then(
        (response) async {
          tempToken = response.tempToken;
          loginUrl = response.url;

          await launchUrl(Uri.parse(loginUrl)).catchError(
            (error) {
              debugPrint('Url_launcher error: $error');
              throw Exception(error);
            },
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<UserModel?> exchangeTempToken(ExchangeTempTokenModel body) async {
    UserModel? user;

    try {
      await authRepositoryImpl.exhangeTempToken(body).then(
        (response) {
          token = response.token;
          user = response.user;
          if (user!.provider == 'tiktok') {
            getIt<SharedPreferences>().setString('tiktok_token', token!);
          } else {
            getIt<SharedPreferences>().setString('instagram_token', token!);
          }
          getIt<Dio>().interceptors.add(
                InterceptorsWrapper(
                  onRequest: (options, handler) async {
                    final token = this.token; // Получаем токен
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
          print(getIt<SharedPreferences>().getKeys());
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
    return user;
  }

  Future<void> getKey() async {
    try {
      await authRepositoryImpl.generateKey().then((value) {
        groupKey = value.key;
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }

  Future<void> setKey(String key) async {
    try {
      await authRepositoryImpl.setKey(key).then((value) {
        debugPrint('Ok');
      });
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
