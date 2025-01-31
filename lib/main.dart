import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tik_dog/pages/auth_loading_page/auth_loading_page.dart';
import 'package:tik_dog/pages/auth_statistic_page/auth_statistic_page.dart';
import 'package:tik_dog/themes.dart';

import 'pages/accept_offer_details_page/accept_offer_details_page.dart';
import 'pages/accept_offer_details_page/denied_offer_details_page.dart';
import 'pages/auth_page/auth_page.dart';
import 'pages/auth_information_page/auth_information_page.dart';
import 'pages/friends_page/friends_page.dart';
import 'pages/init_loading_page/init_loading_page.dart';
import 'pages/offers_page/offers_page.dart';
import 'pages/rating_page/rating_page.dart';
import 'pages/tabs_page/tabs_page.dart';
import 'pages/wallet_page/wallet_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      debugShowFloatingThemeButton: true,
      dark: tiktokTheme,
      light: instaTheme,
      initial: AdaptiveThemeMode.dark,
      overrideMode: AdaptiveThemeMode.dark,
      builder: (light, dark) => MaterialApp.router(
        routerConfig: _router,
        title: 'Flutter Demo',
        theme: dark,
      ),
    );
  }
}

final _router = GoRouter(
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
              builder: (context, state) {
                print(state.extra);
                return AuthLoadingPage(isTikTok: state.extra as bool? ?? false);
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
        path: '/auth_staatistic_page',
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
