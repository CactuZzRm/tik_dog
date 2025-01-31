import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class InitLoadingPage extends StatefulWidget {
  const InitLoadingPage({super.key});

  @override
  State<InitLoadingPage> createState() => _InitLoadingPageState();
}

class _InitLoadingPageState extends State<InitLoadingPage> {
  // @override
  // void initState() {
  //   // WidgetsBinding.instance.addPostFrameCallback((e) {
  //   //   Future.delayed(Duration(seconds: 2)).then((value) {
  //   //     print('qweqwe');
  //   //     if (mounted) context.replaceNamed('Auth');
  //   //   });
  //   // });
  //
  // }
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) context.replaceNamed('Auth');
    });
    // WidgetsBinding.instance.addPostFrameCallback((e) {
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 2)).then((value) {
    //   print('qweqwe');
    //   context.replaceNamed('Auth');
    // });

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
