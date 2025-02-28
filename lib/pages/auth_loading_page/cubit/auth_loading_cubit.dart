import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_dog/data/repositories/auth_repository_impl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/api/models/exchange_temp_token_model.dart';
import '../../../injection_container.dart';

part 'auth_loading_state.dart';

class AuthLoadingCubit extends Cubit<AuthLoadingState> {
  AuthLoadingCubit() : super(AuthLoadingPageInitial());

  String tempToken = '';
  bool wasUrlAlready = false;
  bool wasCallBackAlready = false;
  String? inviteKey;
  CancelToken? _cancelToken;

  Future<void> initialUrlAuth(bool isTikTok) async {
    final provider = isTikTok ? 'tiktok' : 'instagram';
    final url = await getTempToken(provider);

    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication).catchError(
      (error) {
        debugPrint('Url_launcher error: $error');
        throw Exception(error);
      },
    );
    wasUrlAlready = true;
    emit(AuthLoadingPageWebLoginProcess());
  }

  Future<String> getTempToken(String provider) async {
    final authRepositoryImpl = getIt<AuthRepositoryImpl>();
    late final String loginUrl;
    try {
      await authRepositoryImpl.getUrl(provider, inviteKey).then(
        (response) async {
          tempToken = response.tempToken;
          loginUrl = response.url;
        },
      );
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    }
    return loginUrl;
  }

  Future<void> exchangeTempToken() async {
    _cancelToken?.cancel('New request init');
    _cancelToken = CancelToken();

    final authRepositoryImpl = getIt<AuthRepositoryImpl>();
    final ExchangeTempTokenModel body = ExchangeTempTokenModel(tempToken: tempToken);

    try {
      wasCallBackAlready = true;
      final link = getIt<String>();
      await getIt<Dio>().get(link);
      getIt.unregister<String>();
    } catch (e) {
      wasCallBackAlready = false;
      getIt.unregister<String>();
      debugPrint(e.toString());
    }

    try {
      await Future.delayed(const Duration(seconds: 5)).then(
        (value) async {
          await authRepositoryImpl.exhangeTempToken(body, _cancelToken).then(
            (response) {
              final newToken = response.token;
              final user = response.user;
              if (user.provider == 'tiktok') {
                getIt<SharedPreferences>().setString('tiktok_token', newToken);
              } else {
                getIt<SharedPreferences>().setString('instagram_token', newToken);
              }
              getIt<Dio>().interceptors.add(
                    InterceptorsWrapper(
                      onRequest: (options, handler) async {
                        final token = newToken; // Получаем токен
                        options.headers['Authorization'] = 'Bearer $token';
                        handler.next(options);
                      },
                      onResponse: (response, handler) => handler.next(response),
                    ),
                  );
            },
          );
        },
      );
      emit(AuthLoadingSuccessLogin());
      wasCallBackAlready = false;
      wasUrlAlready = false;
    } catch (e) {
      emit(AuthLoadingNotSuccessLogin());
      wasCallBackAlready = false;
      wasUrlAlready = false;
      debugPrint(e.toString());
      throw Exception(e);
    }
  }
}
