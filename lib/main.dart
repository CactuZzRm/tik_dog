import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:tik_dog/pages/auth_loading_page/auth_loading_page.dart';
import 'package:tik_dog/pages/auth_statistic_page/auth_statistic_page.dart';
import 'package:tik_dog/themes.dart';

import 'data/api/models/offer_model.dart';
import 'injection_container.dart';
import 'pages/accept_denied_offer_details_page/accept_offer_details_page.dart';
import 'pages/denied_offer_details_page/denied_offer_details_page.dart';
import 'pages/auth_loading_page/cubit/auth_loading_cubit.dart';
import 'pages/auth_page/auth_page.dart';
import 'pages/auth_information_page/auth_information_page.dart';
import 'pages/auth_page/bloc/auth_bloc.dart';
import 'pages/friends_page/cubit/friends_cubit.dart';
import 'pages/friends_page/friends_page.dart';
import 'pages/offers_page/bloc/offers_bloc.dart';
import 'pages/offers_page/offers_page.dart';
import 'pages/rating_page/cubit/rating_cubit.dart';
import 'pages/rating_page/rating_page.dart';
import 'pages/statistic_page/statistic_page.dart';
import 'pages/tabs_page/cubit/tabs_cubit.dart';
import 'pages/tabs_page/tabs_page.dart';
import 'pages/wallet_page/bloc/wallet_bloc.dart';
import 'pages/wallet_page/wallet_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

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
    debugPrint('Получен deep link: $link');
    if (link.startsWith('https://app.bigpie.ai/api/callback')) {}
  }

  @override
  Widget build(BuildContext context) {
    //Remove this method to stop OneSignal Debugging
    OneSignal.Debug.setLogLevel(OSLogLevel.debug);

    OneSignal.initialize('bb4b550b-9cc6-401c-9ec4-cce5045c4467');

    // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.Notifications.requestPermission(true);

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
          BlocProvider(create: (context) => RatingCubit()),
          BlocProvider(create: (context) => TabsCubit()),
          BlocProvider(create: (context) => AuthLoadingCubit()),
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

class IsFirstBoolWrapper {
  bool isFirst;
  bool hasRequest;
  IsFirstBoolWrapper(this.isFirst, this.hasRequest);
}

final _router = GoRouter(
  debugLogDiagnostics: true,
  redirect: (context, state) async {
    final link = state.uri.toString();

    if (link.contains('callback')) {
      getIt.registerSingleton<String>(link);
      // context.read<AuthLoadingCubit>().authCallBackRequest(link);

      return '/authLoadingPage';
    } else if (link.contains('invite')) {
      if (context.mounted) {
        final splitLink = link.split('/');
        final inviteKey = splitLink[splitLink.length - 1];
        context.read<AuthLoadingCubit>().inviteKey = inviteKey;
      }
      return '/';
    } else {}
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: '/authLoadingPage',
      name: 'AuthLoadingPage',
      builder: (context, state) {
        final String? fromOffersStr = state.uri.queryParameters['fromOffers'];
        final bool? fromOffers = fromOffersStr == null ? null : fromOffersStr == 'true';
        return AuthLoadingPage(fromOffers);
      },
    ),
    GoRoute(
      path: '/auth_statistic_page',
      name: 'AuthStatisticPage',
      builder: (context, state) => const AuthStatisticPage(),
    ),
    GoRoute(
      path: '/auth_information_page',
      name: 'AuthInformationPage',
      builder: (context, state) => const AuthInformationPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, child) => TabsPage(navigationShell: child),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/offers',
              name: 'OffersPage',
              builder: (context, state) => const OffersPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/rating',
              name: 'RatingPage',
              builder: (context, state) => const RatingPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/friends',
              name: 'FriendsPage',
              builder: (context, state) => const FriendsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/wallet',
              name: 'WalletPage',
              builder: (context, state) => const WalletPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/accept_offer_details',
      name: 'AcceptOfferDetailsPage',
      builder: (context, state) {
        final offer = state.extra as OfferModel;

        return AcceptOfferDetailsPage(offer: offer);
      },
    ),
    GoRoute(
      path: '/denied_offer_details',
      name: 'DeniedOfferDetailsPage',
      builder: (context, state) {
        final offer = state.extra as OfferModel;

        return DeniedOfferDetailsPage(offer: offer);
      },
    ),
    GoRoute(
      path: '/statistic',
      name: 'StatisticPage',
      builder: (context, state) => const StatisticPage(),
    ),
  ],
);
