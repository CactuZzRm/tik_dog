import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:tik_dog/data/api/models/exchange_temp_token_model.dart';
import 'package:tik_dog/pages/auth_loading_page/auth_loading_page.dart';
import 'package:tik_dog/pages/auth_statistic_page/auth_statistic_page.dart';
import 'package:tik_dog/themes.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'injection_container.dart';
import 'pages/accept_offer_details_page/accept_offer_details_page.dart';
import 'pages/accept_offer_details_page/denied_offer_details_page.dart';
import 'pages/auth_page/auth_page.dart';
import 'pages/auth_information_page/auth_information_page.dart';
import 'pages/auth_page/bloc/auth_bloc.dart';
import 'pages/friends_page/friends_page.dart';
import 'pages/init_loading_page/init_loading_page.dart';
import 'pages/offers_page/offers_page.dart';
import 'pages/rating_page/rating_page.dart';
import 'pages/tabs_page/tabs_page.dart';
import 'pages/wallet_page/wallet_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;

  @override
  void initState() {
    _appLinks = getIt<AppLinks>();
    super.initState();

    Future<void> checkInitialUri() async {
      print('q');
      final Uri? initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        print('a');
        print('---> Получили initialUri: $initialUri');
        _handleDeepLink(initialUri.toString());
      } else {
        print('b');
      }
    }

    checkInitialUri();
    _initDeepLinkListener();
  }

  void _initDeepLinkListener() async {
    // print('init app links');
    // _appLinks = AppLinks();

    // final String? initialLink = await _appLinks.getInitialLinkString();
    // print(initialLink);
    // if (initialLink != null) {
    //   _handleDeepLink(initialLink);
    // }

    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri.toString());
      }
    }, onError: (err) {
      debugPrint('Ошибка при обработке ссылки: $err');
    });
  }

  void _handleDeepLink(String link) {
    print("Получен deep link: $link");
    print(
        'ПРОВЕРКА УСЛОВИЯ: ${link.startsWith('https://app.bigpie.ai/api/callback')}');
    if (link.startsWith("https://app.bigpie.ai/api/callback")) {}
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      debugShowFloatingThemeButton: true,
      dark: tiktokTheme,
      light: instaTheme,
      initial: AdaptiveThemeMode.dark,
      overrideMode: AdaptiveThemeMode.dark,
      builder: (light, dark) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<AuthBloc>(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: _router,
          title: 'Flutter Demo',
          theme: dark,
        ),
      ),
    );
  }
}

final _router = GoRouter(
  redirect: (context, state) {
    final link = state.uri.toString();

    if (link.contains('callback')) {
      final body = ExchangeTempTokenModel(
        tempToken: context.read<AuthBloc>().tempToken,
      );
      context.read<AuthBloc>().exchangeTempToken(body);
      return '/auth/loading';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => InitLoadingPage(),
      routes: [
        GoRoute(
          path: '/auth',
          name: 'Auth',
          builder: (context, state) => AuthPage(),
          routes: [
            GoRoute(
              path: '/loading',
              name: 'Loading',
              builder: (context, state) => AuthLoadingPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
        path: '/auth_statistic_page',
        name: 'AuthStatisticPage',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;

          return AuthStatisticPage(
            buttonRedirectPageName: extra['buttonRedirectPageName'] as String?,
            buttonText: extra['buttonText'] as String,
          );
        }),
    GoRoute(
      path: '/auth_information_page',
      name: 'AuthInformationPage',
      builder: (context, state) => AuthInformationPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) => TabsPage(navigationShell: child),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/offers',
              name: 'OffersPage',
              builder: (context, state) => OffersPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/rating',
              name: 'RatingPage',
              builder: (context, state) => RatingPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/friends',
              name: 'FriendsPage',
              builder: (context, state) => FriendsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/wallet',
              name: 'WalletPage',
              builder: (context, state) => WalletPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/accept_offer_details',
      name: 'AcceptOfferDetailsPage',
      builder: (context, state) => AcceptOfferDetailsPage(),
    ),
    GoRoute(
      path: '/denied_offer_details',
      name: 'DeniedOfferDetailsPage',
      builder: (context, state) => DeniedOfferDetailsPage(),
    ),
  ],
);
