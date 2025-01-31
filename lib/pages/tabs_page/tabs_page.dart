import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tik_dog/pages/auth_views_page/auth_views_page.dart';
import 'package:tik_dog/themes.dart';

import '../../constants.dart';

class TabsPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final List<String> headerTitle = ['Offers', 'Top Creators', 'Invite friends', 'Wallet'];

  TabsPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(
              height: navigationShell.currentIndex == 3
                  ? 18 + MediaQuery.of(context).padding.top
                  : 38 + MediaQuery.of(context).padding.top),
          if (navigationShell.currentIndex != 3)
            TabsHeader(
              text: headerTitle[navigationShell.currentIndex],
              currentIndex: navigationShell.currentIndex,
            ),
          Expanded(child: navigationShell),
          BottomNavBar(navigationShell: navigationShell),
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
  final String text;
  final int currentIndex;
  final String? imageUrl;

  const TabsHeader({
    super.key,
    required this.text,
    required this.currentIndex,
    this.imageUrl,
  });

  @override
  State<TabsHeader> createState() => _TabsHeaderState();
}

class _TabsHeaderState extends State<TabsHeader> {
  final String name = 'Al';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          widget.currentIndex == 3
              ? SizedBox(
                  height: 70,
                  width: 70,
                  child: ClipOval(
                    child: widget.imageUrl != null
                        ? Image.network(widget.imageUrl!, fit: BoxFit.cover)
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
                  widget.text,
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
                    setState(() {
                      isTikTokSelect = true;
                      AdaptiveTheme.of(context).setDark();
                      selectedSymbol = 'assets/images/TikTokSymbol';
                    });
                  },
                  child: GradientContainer(
                    padding: const EdgeInsets.all(9),
                    needBackground: isTikTokSelect,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/TikTokLogo.svg',
                      width: 13,
                      height: 13,
                      color: isTikTokSelect
                          ? Colors.white
                          : Theme.of(context).extension<CustomThemeData>()!.tabsHeaderSocialNetworkUnselectedIconColor!,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isTikTokSelect = false;
                      selectedSymbol = 'assets/images/InstagramSymbol';
                      AdaptiveTheme.of(context).setLight();
                    });
                  },
                  child: GradientContainer(
                    padding: const EdgeInsets.all(9),
                    needBackground: !isTikTokSelect,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/InstagramLogo.svg',
                      width: 13,
                      height: 13,
                      color: !isTikTokSelect
                          ? Colors.white
                          : Theme.of(context).extension<CustomThemeData>()!.tabsHeaderSocialNetworkUnselectedIconColor!,
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
    return InkWell(
      onTap: () => setState(() {
        widget.navigationShell.goBranch(widget.index);
      }),
      child: Column(
        children: [
          SvgPicture.asset(
            widget.navigationShell.currentIndex != widget.index
                ? 'assets/icons/${widget.iconUrl}'
                : 'assets/icons/Insta${widget.iconUrl}',
            color: AdaptiveTheme.of(context).mode.isDark && widget.navigationShell.currentIndex == widget.index
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
              color: widget.navigationShell.currentIndex != widget.index
                  ? Theme.of(context).textTheme.titleSmall!.color
                  : Theme.of(context).textTheme.titleMedium!.color,
            ),
          ),
        ],
      ),
    );
  }
}
