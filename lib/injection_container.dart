import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_dog/data/repositories/auth_repository_impl.dart';
import 'package:tik_dog/data/repositories/friends_repository_impl.dart';
import 'package:tik_dog/data/repositories/offers_repository_impl.dart';
import 'package:tik_dog/data/repositories/wallet_repository_impl.dart';
import 'package:tik_dog/main.dart';

import 'data/api/api_service.dart';
import 'data/repositories/rating_repository_impl.dart';
import 'pages/auth_page/bloc/auth_bloc.dart';
import 'pages/offers_page/bloc/offers_bloc.dart';

final getIt = GetIt.instance;

void setup() async {
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

  getIt.registerSingleton<AppLinks>(appLinks);

  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<ApiService>(ApiService(getIt<Dio>()));
  getIt.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());

  getIt.registerSingleton<IsFirstBoolWrapper>(IsFirstBoolWrapper(true, false));

  // Репозитории
  getIt.registerSingleton<AuthRepositoryImpl>(AuthRepositoryImpl());
  getIt.registerSingleton<OffersRepositoryImpl>(OffersRepositoryImpl());
  getIt.registerSingleton<FriendsRepositoryImpl>(FriendsRepositoryImpl());
  getIt.registerSingleton<RatingRepositoryImpl>(RatingRepositoryImpl());
  getIt.registerSingleton<WalletRepositoryImpl>(WalletRepositoryImpl());

  // BLoC's
  getIt.registerFactory<AuthBloc>(() => AuthBloc(authRepositoryImpl: getIt<AuthRepositoryImpl>()));
  getIt.registerFactory<OffersBloc>(() => OffersBloc(offersRepositoryImpl: getIt<OffersRepositoryImpl>()));
}
