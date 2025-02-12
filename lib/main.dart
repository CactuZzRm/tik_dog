import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tik_dog/data/api/models/exchange_temp_token_model.dart';
import 'package:tik_dog/pages/auth_loading_page/auth_loading_page.dart';
import 'package:tik_dog/pages/auth_statistic_page/auth_statistic_page.dart';
import 'package:tik_dog/themes.dart';

import 'injection_container.dart';
import 'pages/accept_denied_offer_details_page/accept_offer_details_page.dart';
import 'pages/accept_denied_offer_details_page/denied_offer_details_page.dart';
import 'pages/auth_page/auth_page.dart';
import 'pages/auth_information_page/auth_information_page.dart';
import 'pages/auth_page/bloc/auth_bloc.dart';
import 'pages/friends_page/cubit/friends_cubit.dart';
import 'pages/friends_page/friends_page.dart';
import 'pages/offers_page/bloc/offers_bloc.dart';
import 'pages/offers_page/offers_page.dart';
import 'pages/rating_page/rating_page.dart';
import 'pages/statistic_page/statistic_page.dart';
import 'pages/tabs_page/tabs_page.dart';
import 'pages/wallet_page/bloc/wallet_bloc.dart';
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
      final Uri? initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleDeepLink(initialUri.toString());
      }
    }

    checkInitialUri();
    _initDeepLinkListener();
  }

  void _initDeepLinkListener() async {
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri.toString());
      }
    }, onError: (err) {
      debugPrint('Ошибка при обработке ссылки: $err');
    });
  }

  void _handleDeepLink(String link) {
    debugPrint("Получен deep link: $link");
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
          BlocProvider(create: (context) => getIt<AuthBloc>()),
          BlocProvider(create: (context) => getIt<OffersBloc>()),
          BlocProvider(create: (context) => WalletBloc()),
          BlocProvider(create: (context) => FriendsCubit()),
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
  redirect: (context, state) async {
    final link = state.uri.toString();

    if (link.contains('callback')) {
      final body = ExchangeTempTokenModel(
        tempToken: context.read<AuthBloc>().tempToken,
      );
      try {
        await Future.delayed(Duration(seconds: 5));
        if (context.mounted) {
          await context.read<AuthBloc>().exchangeTempToken(body).then((user) {
            if (context.mounted) {
              context.read<WalletBloc>().add(WalletInitEvent(userModel: user!));
            }
          });
        }
      } catch (e) {
        debugPrint('ERROR: ${e.toString()}');
        return '/';
      }
      return '/auth_statistic_page';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => AuthPage(),
      routes: [
        GoRoute(
          path: '/authLoadingPage',
          name: 'AuthLoadingPage',
          builder: (context, state) => AuthLoadingPage(),
        ),
      ],
    ),
    GoRoute(
      path: '/auth_statistic_page',
      name: 'AuthStatisticPage',
      builder: (context, state) => AuthStatisticPage(),
    ),
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
    GoRoute(
      path: '/statistic',
      name: 'StatisticPage',
      builder: (context, state) => StatisticPage(),
    ),
  ],
);
