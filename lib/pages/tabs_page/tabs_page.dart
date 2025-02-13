import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tik_dog/pages/auth_information_page/auth_information_page.dart';
import 'package:tik_dog/themes.dart';

import '../auth_page/bloc/auth_bloc.dart';
import '../wallet_page/bloc/wallet_bloc.dart';

class TabsPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const TabsPage({required this.navigationShell, super.key});

  @override
  Widget build(BuildContext context) {
    final currentPage = navigationShell.currentIndex;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(
              height:
                  currentPage == 3 ? 18 + MediaQuery.of(context).padding.top : 38 + MediaQuery.of(context).padding.top),
          if (currentPage != 3)
            TabsHeader(
              currentIndex: currentPage,
            ),
          Expanded(child: navigationShell),
          BottomNavBar(navigationShell: navigationShell),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 30, bottom: 7, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BotttomNavBarItem(
            index: 0,
            text: 'Offers',
            iconUrl: 'Home.svg',
            navigationShell: navigationShell,
          ),
          BotttomNavBarItem(
            index: 1,
            text: 'Rating',
            iconUrl: 'Rating.svg',
            navigationShell: navigationShell,
          ),
          BotttomNavBarItem(
            index: 2,
            text: 'Invite Friends',
            iconUrl: 'Friends.svg',
            navigationShell: navigationShell,
          ),
          BotttomNavBarItem(
            index: 3,
            text: 'Wallet',
            iconUrl: 'Wallet.svg',
            navigationShell: navigationShell,
          ),
        ],
      ),
    );
  }
}

class TabsHeader extends StatefulWidget {
  final int currentIndex;
  final String? imageUrl;

  const TabsHeader({
    super.key,
    required this.currentIndex,
    this.imageUrl,
  });

  @override
  State<TabsHeader> createState() => _TabsHeaderState();
}

class _TabsHeaderState extends State<TabsHeader> {
  final List<String> headerTitle = ['Offers', 'Top Creators', 'Invite friends', 'Wallet'];

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthBloc>();
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state is WalletCurrentState) {
          final name = state.user.name;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                widget.currentIndex == 3
                    ? SizedBox(
                        height: 70,
                        width: 70,
                        child: ClipOval(
                          child: state.user.avatar != null && state.user.avatar != ''
                              ? Image.network(state.user.avatar ?? '', fit: BoxFit.cover)
                              : DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(43, 43, 43, 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      name[0] + name[1],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      )
                    : Text(
                        headerTitle[widget.currentIndex],
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          height: 1.27,
                        ),
                      ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).extension<CustomThemeData>()!.tabsHeaderSocialNetworkBackgroundColor!,
                    borderRadius: BorderRadius.circular(145),
                    border: Border.all(
                      color: Theme.of(context).extension<CustomThemeData>()!.tabsHeaderSocialNetworkBorderColor!,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // setState(() {
                          // isTikTokSelect = true;
                          // AdaptiveTheme.of(context).setDark();
                          // selectedSymbol = 'assets/images/TikTokSymbol';
                          // });
                          model.add(SocialNetworkChangeEvent(themeContext: context, isTikTok: true));
                        },
                        child: GradientContainer(
                          padding: const EdgeInsets.all(9),
                          needBackground: model.isTikTok,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/TikTokLogo.svg',
                            width: 13,
                            height: 13,
                            color: model.isTikTok
                                ? Colors.white
                                : Theme.of(context)
                                    .extension<CustomThemeData>()!
                                    .tabsHeaderSocialNetworkUnselectedIconColor!,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          model.add(SocialNetworkChangeEvent(themeContext: context, isTikTok: false));
                        },
                        child: GradientContainer(
                          padding: const EdgeInsets.all(9),
                          needBackground: !model.isTikTok,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/InstagramLogo.svg',
                            width: 13,
                            height: 13,
                            color: !model.isTikTok
                                ? Colors.white
                                : Theme.of(context)
                                    .extension<CustomThemeData>()!
                                    .tabsHeaderSocialNetworkUnselectedIconColor!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return Center(child: Text('error'));
      },
    );
  }
}

class BotttomNavBarItem extends StatefulWidget {
  final int index;
  final String text;
  final String iconUrl;
  final StatefulNavigationShell navigationShell;
  const BotttomNavBarItem({
    super.key,
    required this.index,
    required this.text,
    required this.iconUrl,
    required this.navigationShell,
  });

  @override
  State<BotttomNavBarItem> createState() => _BotttomNavBarItemState();
}

class _BotttomNavBarItemState extends State<BotttomNavBarItem> {
  @override
  Widget build(BuildContext context) {
    final currentPage = widget.navigationShell.currentIndex;

    return InkWell(
      onTap: () {
        widget.navigationShell.goBranch(widget.index);
      },
      child: Column(
        children: [
          SvgPicture.asset(
            currentPage != widget.index ? 'assets/icons/${widget.iconUrl}' : 'assets/icons/Insta${widget.iconUrl}',
            color: AdaptiveTheme.of(context).mode.isDark && currentPage == widget.index
                ? Color.fromRGBO(255, 29, 101, 1)
                : null,
          ),
          const SizedBox(height: 4),
          Text(
            widget.text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.7,
              color: currentPage != widget.index
                  ? Theme.of(context).textTheme.titleSmall!.color
                  : Theme.of(context).textTheme.titleMedium!.color,
            ),
          ),
        ],
      ),
    );
  }
}
