import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:get_it/get_it.dart';
import 'package:tik_dog/data/api/models/exchange_temp_token_model.dart';
import 'package:tik_dog/data/repositories/auth_repository_impl.dart';

import '../../../constants.dart';
import '../../../injection_container.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl authRepositoryImpl;
  String tempToken = '';
  String loginUrl = '';
  String? token = '';
  late bool isTikTok;

  AuthBloc({required this.authRepositoryImpl}) : super(AuthLoading()) {
    on<AuthLoadingEvent>((event, emit) async {
      await Future.delayed(Duration(seconds: 2)).then((value) {
        emit(AuthInitial());
      });
    });
    on<AuthLoginEvent>((event, emit) async {
      final selectedSocialNetwork =
          event.socialNetwork == SocialNetworks.tiktok ? 'tiktok' : 'instagram';
      isTikTok = event.socialNetwork == SocialNetworks.tiktok ? true : false;
      await getTempToken(selectedSocialNetwork);
    });
  }

  Future<void> getTempToken(String provider) async {
    try {
      await authRepositoryImpl.getUrl(provider).then(
        (response) async {
          tempToken = response.tempToken;
          loginUrl = response.url;

          await launchUrl(Uri.parse(loginUrl)).catchError(
            (error) => debugPrint('Url_launcher error: $error'),
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> exchangeTempToken(ExchangeTempTokenModel body) async {
    //TODO: Токен не успевает улавить, что пользователь авторизован
    await Future.delayed(Duration(seconds: 2));
    try {
      await authRepositoryImpl.exhangeTempToken(body).then((response) {
        token = response.token;

        getIt<Dio>().interceptors.add(InterceptorsWrapper(
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
            ));
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
