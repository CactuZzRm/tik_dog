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

    await launchUrl(Uri.parse(url), mode: LaunchMode.platformDefault).catchError(
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
      print('-----\n$wasCallBackAlready\n-----');
      final link = getIt<String>();
      await getIt<Dio>().get(link);
      getIt.unregister<String>();
    } catch (e) {
      wasCallBackAlready = false;
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

  // Future<void> authCallBackRequest(String link) async {
  //   try {
  //     await getIt<Dio>().get(link);
  //     emit(AuthLoadingPageCallback());
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // Future<void> getLocalAuth(bool isTikTok) async {
  //   print('get local auth');
  //   if (getIt<SharedPreferences>().getString('tiktok_token') != null && isTikTok ||
  //       getIt<SharedPreferences>().getString('instagram_token') != null && !isTikTok) {
  //     setToken(isTikTok);
  //     // return true;
  //     emit(AuthLoadingPageSuccess());
  //   }
  //   // return false;
  //   emit(AuthLoadingPageCallback());
  //   // emit(AuthLoadingPageCallback());
  // }

  // Future<void> getNotLocalAuth(String tempToken, BuildContext context) async {
  //   print('get non local auth');
  //   final body = ExchangeTempTokenModel(
  //     tempToken: tempToken,
  //   );

  //   try {
  //     await Future.delayed(const Duration(seconds: 5)).then((value) async {
  //       if (context.mounted) {
  //         await context.read<AuthBloc>().exchangeTempToken(body).then((user) {
  //           if (context.mounted) {
  //             emit(AuthLoadingPageSuccess());
  //           }
  //         });
  //       }
  //     });
  //   } catch (e) {
  //     if (context.mounted) {
  //       // context.replace('/');
  //       context.pop();
  //     }

  //     debugPrint('ERROR: ${e.toString()}');
  //     emit(AuthLoadingPageError());
  //     throw Exception(e);
  //   }
  // }

  // void setToken(bool isTikTok) {
  //   getIt<Dio>().interceptors.add(
  //         InterceptorsWrapper(
  //           onRequest: (options, handler) async {
  //             final token = getIt<SharedPreferences>().getString(isTikTok ? 'tiktok_token' : 'instagram_token');
  //             if (token != null) {
  //               options.headers['Authorization'] = 'Bearer $token';
  //             }
  //             handler.next(options);
  //           },
  //           onResponse: (response, handler) {
  //             handler.next(response);
  //           },
  //         ),
  //       );
  // }
}
