import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tik_dog/data/repositories/auth_repository_impl.dart';
import 'package:tik_dog/domain/repositories/auth_repository.dart';

import 'data/api/api_service.dart';
import 'pages/auth_page/bloc/auth_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  final dio = Dio();
  final appLinks = AppLinks();

  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseHeader: false,
    responseBody: true,
    error: true,
    compact: true,
  ));
  (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    final client = HttpClient();
    client.badCertificateCallback = (cert, host, port) => true;
    return client;
  };

  // dio.request('https://bigpie.ai/api/login?provider=tiktok');

  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<ApiService>(ApiService(getIt<Dio>()));
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<AuthRepositoryImpl>(
    AuthRepositoryImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerSingleton<AppLinks>(AppLinks());
  // getIt.registerSingleton<GetCarts>(GetCarts(
  //   repository: getIt<CartRepository>(),
  // ));
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(authRepositoryImpl: getIt<AuthRepositoryImpl>()),
  );
}
