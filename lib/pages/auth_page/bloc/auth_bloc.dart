import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:tik_dog/data/repositories/auth_repository_impl.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl authRepositoryImpl;
  String tempToken = '';
  String loginUrl = '';

  // final controller = WebViewController()
  //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //   ..setUserAgent('Mozilla/5.0 (Windows Mobile 10; Android 10.0; Microsoft; Lumia 950XL)')
  //   ..setNavigationDelegate(
  //     NavigationDelegate(
  //       onProgress: (int progress) {
  //         // Update loading bar.
  //       },
  //       onPageStarted: (String url) {},
  //       onPageFinished: (String url) {},
  //       onHttpError: (HttpResponseError error) {},
  //       onWebResourceError: (WebResourceError error) {},
  //       // onNavigationRequest: (NavigationRequest request) {
  //       //   if (request.url.startsWith('https://www.youtube.com/')) {
  //       //     return NavigationDecision.prevent;
  //       //   }
  //       //   return NavigationDecision.navigate;
  //       // },
  //     ),
  //   );
  // ..loadRequest(Uri.parse('https://flutter.dev'));

  AuthBloc({required this.authRepositoryImpl}) : super(AuthLoading()) {
    on<AuthLoadingEvent>((event, emit) async {
      await Future.delayed(Duration(seconds: 2))
          .then((value) => emit(AuthInitial()));
    });
    on<AuthEvent>((event, emit) {});
    on<InitEvent>((event, emit) {});
    on<AuthLoginEvent>((event, emit) {
      final selectedSocialNetwork =
          event.socialNetwork == SocialNetworks.tiktok ? 'tiktok' : 'instagram';
      getTempToken(selectedSocialNetwork);
    });
  }

  void getTempToken(String provider) async {
   
    final request = await authRepositoryImpl.getUrl('tiktok').then((response) {
      tempToken = response.tempToken;
      loginUrl = response.url;
    }).catchError((error) {
      print(error);
      // ErrorResponse.fromJson(((error as DioException).response!.data));
      print(((error as DioException).response!).data);
    });

     final result = await FlutterWebAuth2.authenticate(url: loginUrl, callbackUrlScheme: "my-custom-app");
    // controller.loadRequest(Uri.parse(
    //     'https://www.tiktok.com/v2/auth/authorize/?client_key=sbawju4w53byhea9zn&state=s8e2vwOLltac11cJvsW8&response_type=code&scope=user.info.basic%2Cuser.info.stats&redirect_uri=https%3A%2F%2Fbigpie.ai%2Fapi%2Fcallback%2Ftiktok'));
  }
}
