import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tik_dog/constants.dart';
import 'package:tik_dog/pages/auth_page/bloc/auth_bloc.dart';
import 'package:tik_dog/pages/init_loading_page/init_loading_page.dart';

import '../../themes.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthBloc>();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          model.add(AuthLoadingEvent());
          return InitLoadingPage();
        } else if (state is AuthCurrentState) {
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 27),
                SvgPicture.asset(
                  'assets/icons/BIGpie.svg',
                  width: 171,
                  height: 70,
                ),
                const SizedBox(height: 22),
                Text(
                  'Chose your App\nCheck your Star',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.134,
                      ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      SizedBox(width: double.infinity),
                      Positioned(
                        left: 0,
                        bottom: 190,
                        child: Image.asset('assets/images/InstagramLogo.png'),
                      ),
                      Positioned(
                        right: 26,
                        left: 26,
                        bottom: -50,
                        child: Image.asset('assets/images/BlueTorchFull.png'),
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
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Image.asset('assets/images/TikTokLogo.png'),
                      ),
                    ],
                  ),
                ),
                AuthButton(
                  text: 'Continue with Instagram',
                  iconSource: 'assets/icons/InstagramLogo.svg',
                  onPressed: () {
                    selectedSymbol = 'assets/images/InstagramSymbol';
                    context.pushNamed('AuthLoadingPage');
                    model.add(AuthLoginEvent(socialNetwork: SocialNetworks.instagram));
                  },
                ),
                const SizedBox(height: 24),
                AuthButton(
                  text: 'Continue with TikTok',
                  iconSource: 'assets/icons/TikTokLogo.svg',
                  onPressed: () {
                    selectedSymbol = 'assets/images/TikTokSymbol';
                    context.pushNamed('AuthLoadingPage');
                    model.add(AuthLoginEvent(socialNetwork: SocialNetworks.tiktok));
                  },
                ),
                const SizedBox(height: 21),
              ],
            ),
          );
        } else {
          return Center(
            child: Text('errorus'),
          );
        }
      },
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  final String iconSource;
  final Function() onPressed;
  const AuthButton({
    super.key,
    required this.text,
    required this.iconSource,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Color.fromRGBO(77, 77, 77, 1)),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(iconSource),
              ),
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
