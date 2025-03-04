// ignore_for_file: deprecated_member_use

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tik_dog/pages/auth_loading_page/cubit/auth_loading_cubit.dart';
import 'package:tik_dog/pages/rating_page/cubit/rating_cubit.dart';

import '../../constants.dart';
import '../auth_page/bloc/auth_bloc.dart';
import '../friends_page/cubit/friends_cubit.dart';
import '../offers_page/bloc/offers_bloc.dart';
import '../wallet_page/bloc/wallet_bloc.dart';

class AuthLoadingPage extends StatefulWidget {
  const AuthLoadingPage(this.fromOffers, {super.key});

  final bool? fromOffers;

  @override
  State<AuthLoadingPage> createState() => _AuthLoadingPageState();
}

class _AuthLoadingPageState extends State<AuthLoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    if (!context.read<AuthLoadingCubit>().wasUrlAlready) {
      final isTikTok = context.read<AuthBloc>().isTikTok;
      context.read<AuthLoadingCubit>().initialUrlAuth(isTikTok);
    }
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (context.mounted && !context.read<AuthLoadingCubit>().wasCallBackAlready) {
        context.read<AuthLoadingCubit>().exchangeTempToken();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: Stack(
        children: [
          Positioned(
            left: 2,
            top: 170,
            child: Image.asset(
              'assets/images/BlueTorchInitLoadingPage.png',
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/InstagramSymbol.png',
              width: 254,
              height: 275,
            ),
          ),
          Positioned(
            right: -150,
            bottom: 0,
            child: Image.asset(
              'assets/images/TikTokSymbol.png',
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: AnimatedHorizontalSteps()),
              const SizedBox(height: 53),
              Padding(
                padding: const EdgeInsets.only(left: 38, right: 56),
                child: Text(
                  'Give us time, we’re working through your incredible stats!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.21,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return BlocListener<AuthLoadingCubit, AuthLoadingState>(
      listener: (context, state) {
        if (state is AuthLoadingSuccessLogin) {
          final walletModel = context.read<WalletBloc>();
          final isTikTok = context.read<AuthBloc>().isTikTok;

          walletModel.add(GetUserData());

          selectedSymbol = isTikTok ? 'assets/images/TikTokSymbol' : 'assets/images/InstagramSymbol';
          context.read<WalletBloc>().isTikTok = isTikTok;

          context.read<OffersBloc>().makeInit();
          context.read<RatingCubit>().makeInit();
          context.read<FriendsCubit>().makeInit();

          context.pushReplacementNamed('AuthStatisticPage');
        } else if (state is AuthLoadingNotSuccessLogin) {
          widget.fromOffers != null ? context.pop() : context.go('/');
        }
      },
      child: BlocBuilder<AuthLoadingCubit, AuthLoadingState>(
        builder: (context, state) {
          if (state is AuthLoadingPageInitial) {
            return content;
          } else if (state is AuthLoadingSuccessLogin) {
            return content;
          } else if (state is AuthLoadingNotSuccessLogin) {
            return content;
          } else {
            return content;
          }
        },
      ),
    );
  }
}

class AnimatedHorizontalSteps extends StatefulWidget {
  const AnimatedHorizontalSteps({
    super.key,
  });

  @override
  State<AnimatedHorizontalSteps> createState() => _AnimatedHorizontalStepsState();
}

class _AnimatedHorizontalStepsState extends State<AnimatedHorizontalSteps> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation1;
  late final Animation<double> _reversedAnimation1;
  late final Animation<double> _animation2;
  late final Animation<double> _reversedAnimation2;
  late final Animation<double> _animation3;
  late final Animation<double> _reversedAnimation3;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation1 = Tween<double>(begin: 0.0, end: 0.12).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.25, curve: Curves.easeInOut),
      ),
    );
    _reversedAnimation1 = Tween<double>(begin: 0.12, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.5, curve: Curves.easeInOut),
      ),
    );

    _animation2 = Tween<double>(begin: 0.0, end: 0.25).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.5, curve: Curves.easeInOut),
      ),
    );
    _reversedAnimation2 = Tween<double>(begin: 0.25, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.75, curve: Curves.easeInOut),
      ),
    );

    _animation3 = Tween<double>(begin: 0.0, end: 0.42).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.75, curve: Curves.easeInOut),
      ),
    );
    _reversedAnimation3 = Tween<double>(begin: 0.42, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color lightThemeStepColor = const Color.fromRGBO(0, 0, 0, 1);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _animation1,
          builder: (context, child) => Opacity(
            opacity: _controller.value < 0.25 ? _animation1.value : _reversedAnimation1.value,
            child: SvgPicture.asset('assets/icons/ColoredStep.svg',
                color: AdaptiveTheme.of(context).mode.isLight ? lightThemeStepColor : null),
          ),
        ),
        const SizedBox(width: 8),
        AnimatedBuilder(
          animation: _animation2,
          builder: (context, child) => Opacity(
            opacity: _controller.value < 0.5 ? _animation2.value : _reversedAnimation2.value,
            child: SvgPicture.asset('assets/icons/ColoredStep.svg',
                color: AdaptiveTheme.of(context).mode.isLight ? lightThemeStepColor : null),
          ),
        ),
        const SizedBox(width: 8),
        AnimatedBuilder(
          animation: _animation3,
          builder: (context, child) => Opacity(
            opacity: _controller.value < 0.75 ? _animation3.value : _reversedAnimation3.value,
            child: SvgPicture.asset('assets/icons/ColoredStep.svg',
                color: AdaptiveTheme.of(context).mode.isLight ? lightThemeStepColor : null),
          ),
        ),
      ],
    );
  }
}


// final requestFlagsBoolWrapper = getIt<IsFirstBoolWrapper>();
//     // print('init state');

//     if (context.mounted) {
//       final isTikTok = context.read<AuthBloc>().isTikTok;
//       // print('$isTikTok' + '<<<<<');
//       if (getIt<SharedPreferences>().getString('tiktok_token') != null && isTikTok ||
//           getIt<SharedPreferences>().getString('instagram_token') != null && !isTikTok) {
//         context.read<WalletBloc>().add(GetUserData()); // TODO: Костыль по получению данных пользователя
//         setToken(isTikTok);
//         context.goNamed('OffersPage');
//       } else if (!requestFlagsBoolWrapper.isFirst && !requestFlagsBoolWrapper.hasRequest) {
//         final body = ExchangeTempTokenModel(
//           tempToken: context.read<AuthBloc>().tempToken,
//         );

//         try {
//           final link = getIt<String>();

//           await getIt<Dio>().get(link);

//           getIt<IsFirstBoolWrapper>().isFirst = false;
//           getIt<IsFirstBoolWrapper>().hasRequest = true;
//           getIt.unregister<String>();
//         } catch (e) {
//           debugPrint(e.toString());
//         }

//         try {
//           await Future.delayed(const Duration(seconds: 5)).then(
//             (value) async {
//               if (mounted) {
//                 await context.read<AuthBloc>().exchangeTempToken(body).then((user) {
//                   if (mounted) {
//                     context.read<WalletBloc>().add(GetUserData());

//                     context.read<AuthBloc>().isTikTok
//                         ? AdaptiveTheme.of(context).setDark()
//                         : AdaptiveTheme.of(context).setLight();
//                     selectedSymbol = context.read<AuthBloc>().isTikTok
//                         ? 'assets/images/TikTokSymbol'
//                         : 'assets/images/InstagramSymbol';
//                     context.replaceNamed('AuthStatisticPage');
//                   }
//                 });
//               }
//             },
//           );
//         } catch (e) {
//           if (mounted) {
//             context.replace('/');
//           }
//           debugPrint('ERROR: ${e.toString()}');
//           throw Exception(e);
//         }
//       } else {}
//     }