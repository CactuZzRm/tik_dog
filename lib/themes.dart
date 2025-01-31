import 'package:flutter/material.dart';

class CustomThemeData extends ThemeExtension<CustomThemeData> {
  final Color? ratingProfileCardBackgroundColor;
  final Color? offersPageCategoryBorderColor;
  final Color? tabsHeaderSocialNetworkBackgroundColor;
  final Color? tabsHeaderSocialNetworkBorderColor;
  final Color? tabsHeaderSocialNetworkUnselectedIconColor;
  final Color? offersPageHeaderUnselectedCategoryColor;
  final Color? offersAcceptGradientFirstColor;
  final Color? offersAcceptGradientSecondColor;
  final Color? offerDeniedReasonSelectBackgroundColor;
  final Color? offerDeniedReasonScaffoldBackgroundColor;
  final Color? offerDeniedReasonTextFieldHintColor;
  final Color? walletTikTokButtonBackgroundColor;
  final Color? walletAccountActionButtonBackgroundColor;
  final Color? walletAccountActionButtonBorderColor;
  final Color? offersAcceptEmailHintColor;
  final Color? authStatisticsPagestatisticContainerTextColor;

  CustomThemeData({
    this.ratingProfileCardBackgroundColor,
    this.offersPageCategoryBorderColor,
    this.tabsHeaderSocialNetworkBackgroundColor,
    this.tabsHeaderSocialNetworkBorderColor,
    this.tabsHeaderSocialNetworkUnselectedIconColor,
    this.offersPageHeaderUnselectedCategoryColor,
    this.offersAcceptGradientFirstColor,
    this.offersAcceptGradientSecondColor,
    this.offerDeniedReasonSelectBackgroundColor,
    this.offerDeniedReasonScaffoldBackgroundColor,
    this.offerDeniedReasonTextFieldHintColor,
    this.walletTikTokButtonBackgroundColor,
    this.walletAccountActionButtonBackgroundColor,
    this.walletAccountActionButtonBorderColor,
    this.offersAcceptEmailHintColor,
    this.authStatisticsPagestatisticContainerTextColor,
  });

  @override
  ThemeExtension<CustomThemeData> copyWith() {
    //TODO: Добаработать метод
    throw UnimplementedError();
  }

  @override
  ThemeExtension<CustomThemeData> lerp(
      covariant ThemeExtension<CustomThemeData>? other, double t) {
    if (other is! CustomThemeData) {
      return this;
    }
    return CustomThemeData(
      ratingProfileCardBackgroundColor: Color.lerp(
        ratingProfileCardBackgroundColor,
        other.ratingProfileCardBackgroundColor,
        t,
      ),
      offersPageCategoryBorderColor: Color.lerp(offersPageCategoryBorderColor,
          other.offersPageCategoryBorderColor, t),
      tabsHeaderSocialNetworkBackgroundColor: Color.lerp(
        tabsHeaderSocialNetworkBackgroundColor,
        other.tabsHeaderSocialNetworkBackgroundColor,
        t,
      ),
      tabsHeaderSocialNetworkBorderColor: Color.lerp(
        tabsHeaderSocialNetworkBorderColor,
        other.tabsHeaderSocialNetworkBorderColor,
        t,
      ),
      tabsHeaderSocialNetworkUnselectedIconColor: Color.lerp(
        tabsHeaderSocialNetworkUnselectedIconColor,
        other.tabsHeaderSocialNetworkUnselectedIconColor,
        t,
      ),
      offersPageHeaderUnselectedCategoryColor: Color.lerp(
        offersPageHeaderUnselectedCategoryColor,
        other.offersPageHeaderUnselectedCategoryColor,
        t,
      ),
      offersAcceptGradientFirstColor: Color.lerp(
        offersAcceptGradientSecondColor,
        other.offersAcceptGradientSecondColor,
        t,
      ),
      offersAcceptGradientSecondColor: Color.lerp(
        offersAcceptGradientSecondColor,
        other.offersAcceptGradientSecondColor,
        t,
      ),
      offerDeniedReasonSelectBackgroundColor: Color.lerp(
        offerDeniedReasonSelectBackgroundColor,
        other.offerDeniedReasonSelectBackgroundColor,
        t,
      ),
      offerDeniedReasonScaffoldBackgroundColor: Color.lerp(
        offerDeniedReasonScaffoldBackgroundColor,
        other.offerDeniedReasonScaffoldBackgroundColor,
        t,
      ),
      offerDeniedReasonTextFieldHintColor: Color.lerp(
        offerDeniedReasonTextFieldHintColor,
        other.offerDeniedReasonTextFieldHintColor,
        t,
      ),
      walletTikTokButtonBackgroundColor: Color.lerp(
        walletTikTokButtonBackgroundColor,
        other.walletTikTokButtonBackgroundColor,
        t,
      ),
      walletAccountActionButtonBackgroundColor: Color.lerp(
        walletAccountActionButtonBackgroundColor,
        other.walletAccountActionButtonBackgroundColor,
        t,
      ),
      walletAccountActionButtonBorderColor: Color.lerp(
        walletAccountActionButtonBorderColor,
        other.walletAccountActionButtonBorderColor,
        t,
      ),
      offersAcceptEmailHintColor: Color.lerp(
        offersAcceptEmailHintColor,
        other.offersAcceptEmailHintColor,
        t,
      ),
      authStatisticsPagestatisticContainerTextColor: Color.lerp(
        authStatisticsPagestatisticContainerTextColor,
        other.authStatisticsPagestatisticContainerTextColor,
        t,
      ),
    );
  }
}

final tiktokTheme = ThemeData(
  extensions: <ThemeExtension<dynamic>>[
    CustomThemeData(
      ratingProfileCardBackgroundColor: Color.fromRGBO(36, 36, 36, 1),
      offersPageCategoryBorderColor: Color.fromRGBO(55, 55, 62, 1),
      tabsHeaderSocialNetworkBackgroundColor:
          Color.fromRGBO(255, 255, 255, 0.2),
      tabsHeaderSocialNetworkBorderColor: Color.fromRGBO(255, 255, 255, 0.15),
      tabsHeaderSocialNetworkUnselectedIconColor:
          Color.fromRGBO(255, 255, 255, 1),
      offersPageHeaderUnselectedCategoryColor:
          Color.fromRGBO(255, 255, 255, 0.8),
      offersAcceptGradientFirstColor: Color.fromRGBO(28, 28, 30, 1),
      offersAcceptGradientSecondColor: Color.fromRGBO(0, 0, 0, 0),
      offerDeniedReasonSelectBackgroundColor: Color.fromRGBO(28, 28, 30, 0.9),
      offerDeniedReasonScaffoldBackgroundColor: Color.fromRGBO(0, 0, 0, 1),
      offerDeniedReasonTextFieldHintColor: Color.fromRGBO(255, 255, 255, 37),
      walletTikTokButtonBackgroundColor: Color.fromRGBO(44, 44, 44, 1),
      walletAccountActionButtonBackgroundColor: Colors.transparent,
      walletAccountActionButtonBorderColor: Color.fromRGBO(86, 86, 86, 1),
      offersAcceptEmailHintColor: Color.fromRGBO(255, 255, 255, 0.5),
      authStatisticsPagestatisticContainerTextColor:
          Color.fromRGBO(255, 29, 101, 1),
    ),
  ],
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Color.fromRGBO(255, 29, 101, 1),
  cardColor: Color.fromRGBO(255, 255, 255, 0.2),
  hintColor: Color.fromRGBO(255, 255, 255, 1),
  highlightColor: Color.fromRGBO(0, 0, 0, 1),
  canvasColor: Colors.white,
  splashColor: Color.fromRGBO(28, 28, 30, 1),
  dividerColor: Color.fromRGBO(73, 73, 75, 1),
  textTheme: const TextTheme(
    titleSmall: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.5)),
    titleMedium: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
    bodySmall: TextStyle(
        fontSize: 13, color: Color.fromRGBO(157, 157, 157, 1), height: 1),
    bodyMedium: TextStyle(fontSize: 15, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 32, color: Colors.white, height: 1),
  ),
);

final instaTheme = ThemeData(
  extensions: [
    CustomThemeData(
      ratingProfileCardBackgroundColor: Color.fromRGBO(108, 34, 193, 1),
      offersPageCategoryBorderColor: Color.fromRGBO(212, 212, 212, 1),
      tabsHeaderSocialNetworkBackgroundColor: Color.fromRGBO(243, 243, 243, 1),
      tabsHeaderSocialNetworkBorderColor: Color.fromRGBO(239, 239, 239, 1),
      tabsHeaderSocialNetworkUnselectedIconColor: Color.fromRGBO(0, 0, 0, 1),
      offersPageHeaderUnselectedCategoryColor: Color.fromRGBO(99, 99, 99, 0.8),
      offersAcceptGradientFirstColor: Color.fromRGBO(255, 255, 255, 1),
      offersAcceptGradientSecondColor: Color.fromRGBO(255, 255, 255, 0),
      offerDeniedReasonSelectBackgroundColor: Color.fromRGBO(255, 255, 255, 1),
      offerDeniedReasonScaffoldBackgroundColor:
          Color.fromRGBO(235, 235, 235, 1),
      offerDeniedReasonTextFieldHintColor: Color.fromRGBO(0, 0, 0, 0.5),
      walletTikTokButtonBackgroundColor: Color.fromRGBO(0, 0, 0, 1),
      walletAccountActionButtonBackgroundColor: Colors.transparent,
      walletAccountActionButtonBorderColor: Color.fromRGBO(190, 190, 190, 1),
      offersAcceptEmailHintColor: Color.fromRGBO(176, 176, 176, 1),
      authStatisticsPagestatisticContainerTextColor:
          Color.fromRGBO(0, 0, 0, 1),
    )
  ],
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  primaryColor: Color.fromRGBO(255, 29, 101, 1),
  cardColor: Color.fromRGBO(24, 24, 24, 1),
  hintColor: Color.fromRGBO(255, 255, 255, 1),
  highlightColor: Color.fromRGBO(255, 255, 255, 1),
  canvasColor: Colors.black,
  splashColor: Color.fromRGBO(255, 255, 255, 1),
  dividerColor: Colors.blue,
  textTheme: const TextTheme(
    titleSmall: TextStyle(color: Color.fromRGBO(157, 157, 157, 1)),
    titleMedium: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
    bodySmall: TextStyle(
        fontSize: 13, color: Color.fromRGBO(255, 255, 255, 1), height: 1),
    bodyMedium: TextStyle(fontSize: 15, color: Colors.black),
    bodyLarge: TextStyle(fontSize: 32, color: Colors.black, height: 1),
  ),
).copyWith();
