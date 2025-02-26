import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../data/api/models/exchange_temp_token_model.dart';
import '../../../injection_container.dart';
import '../../auth_page/bloc/auth_bloc.dart';
import '../../wallet_page/bloc/wallet_bloc.dart';

part 'auth_loading_state.dart';

class AuthLoadingCubit extends Cubit<AuthLoadingPageState> {
  AuthLoadingCubit() : super(AuthLoadingPageInitial());

  Future<void> authCallBackRequest(String link) async {
    try {
      await getIt<Dio>().get(link);
      print('\n\n\n\n\n\n\nyeeeeeeeeeeeeeeeeeeeeeeee\n');
      emit(AuthLoadingPageCallback());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool getLocalAuth(bool isTikTok) {
    if (getIt<SharedPreferences>().getString('tiktok_token') != null && isTikTok ||
        getIt<SharedPreferences>().getString('instagram_token') != null && !isTikTok) {
      setToken(isTikTok);
      return true;
    }
    return false;
  }

  Future<void> getNotLocalAuth(String tempToken, BuildContext context) async {
    final body = ExchangeTempTokenModel(
      tempToken: tempToken,
    );

    try {
      await Future.delayed(const Duration(seconds: 5)).then((value) async {
        if (context.mounted) {
          await context.read<AuthBloc>().exchangeTempToken(body).then((user) {
            if (context.mounted) {
              context.read<WalletBloc>().add(GetUserData());
              context.read<AuthBloc>().isTikTok
                  ? AdaptiveTheme.of(context).setDark()
                  : AdaptiveTheme.of(context).setLight();
              selectedSymbol =
                  context.read<AuthBloc>().isTikTok ? 'assets/images/TikTokSymbol' : 'assets/images/InstagramSymbol';
              context.replaceNamed('AuthStatisticPage');
            }
          });
        }
      });
    } catch (e) {
      if (context.mounted) {
        context.replace('/');
      }

      debugPrint('ERROR: ${e.toString()}');
      throw Exception(e);
    }
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
