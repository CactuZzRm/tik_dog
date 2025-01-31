import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AuthLoadingPage extends StatefulWidget {
  final bool isTikTok;
  const AuthLoadingPage({required this.isTikTok, super.key});

  @override
  State<AuthLoadingPage> createState() => _AuthLoadingPageState();
}

class _AuthLoadingPageState extends State<AuthLoadingPage> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((e) {
  //     Future.delayed(Duration(seconds: 2)).then((value) {
  //       if (mounted) {
  //         !widget.isTikTok ? AdaptiveTheme.of(context).setLight() : () {};
  //         print('qweqweqwe');
  //         context.replaceNamed('AuthStatisticPage', extra: {
  //           'buttonText': 'Next',
  //           'buttonRedirectPageName': 'AuthInformationPage',
  //         });
  //       }
  //     });
  //   });
  // }
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        !widget.isTikTok ? AdaptiveTheme.of(context).setLight() : () {};
        context.goNamed('AuthStatisticPage', extra: {
          'buttonText': 'Next',
          'buttonRedirectPageName': 'AuthInformationPage',
        });
      }
    });
    // WidgetsBinding.instance.addPostFrameCallback((e) {

    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Center(
                child: Image.asset(
                  'assets/images/StepsHorizontalInitLoadingPage.png',
                ),
              ),
              const SizedBox(height: 58),
              SvgPicture.asset('assets/icons/BIGpie.svg'),
            ],
          ),
        ],
      ),
    );
  }
}
