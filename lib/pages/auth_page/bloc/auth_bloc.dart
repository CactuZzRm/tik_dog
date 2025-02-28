import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_dog/data/repositories/auth_repository_impl.dart';

import '../../../constants.dart';
import '../../../injection_container.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl authRepositoryImpl;
  late bool isTikTok;

  AuthBloc({required this.authRepositoryImpl}) : super(AuthLoading()) {
    on<AuthLoadingEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2)).then((value) {
        emit(AuthCurrentState());
      });
    });
    on<AuthLoginEvent>((event, emit) async {
      isTikTok = event.socialNetwork == SocialNetworks.tiktok ? true : false;

      if (isTikTok && getIt<SharedPreferences>().getString('tiktok_token') != null ||
          !isTikTok && getIt<SharedPreferences>().getString('instagram_token') != null) {
        setToken(isTikTok);
        isTikTok ? AdaptiveTheme.of(event.themeContext).setDark() : AdaptiveTheme.of(event.themeContext).setLight();
        selectedSymbol = isTikTok ? 'assets/images/TikTokSymbol' : 'assets/images/InstagramSymbol';
        emit(AuthAuthenticatedState());
      } else {
        emit(AuthUnauthenticatedState());
      }
    });
  }

  void setToken(bool isTikTok) {
    getIt<Dio>().interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) async {
              final token = getIt<SharedPreferences>().getString(isTikTok ? 'tiktok_token' : 'instagram_token');
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
  }
}
