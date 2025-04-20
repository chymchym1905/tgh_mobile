import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../imports.dart';

ThemeData light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 205, 179, 124), dynamicSchemeVariant: DynamicSchemeVariant.fidelity),
    // appBarTheme: AppBarTheme(
    //   // backgroundColor: Color.fromARGB(255, 255, 255, 255),
    //   // foregroundColor: Color.fromRGBO(0, 0, 0, 1),
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //       statusBarBrightness: kIsWeb
    //           ? Brightness.light
    //           : defaultTargetPlatform == TargetPlatform.iOS
    //               ? Brightness.light
    //               : Brightness.dark,
    //       statusBarIconBrightness: kIsWeb
    //           ? Brightness.light
    //           : defaultTargetPlatform == TargetPlatform.iOS
    //               ? Brightness.light
    //               : Brightness.dark,
    //       statusBarColor: Colors.transparent,
    //       systemNavigationBarColor: Colors.transparent,
    //       systemNavigationBarIconBrightness: Brightness.dark),
    // ),
    textTheme: Typography.englishLike2018.apply(bodyColor: Colors.black),
    extensions: const [
      ThemeAssets(
        //home
        homeIconSvg: 'assets/appicon/homeicon_light.svg',
        homeLottieJson: 'assets/appicon/homeicon_light.json',
        //leaderboard
        lbIconSvg: 'assets/appicon/leaderboard_light.svg',
        lbLottieJson: 'assets/appicon/leaderboard_light.json',
        //profile
        profileIconSvg: 'assets/appicon/profile_light.svg',
        profileLottieJson: 'assets/appicon/profile_light.json',
        //trophy
        trophyIconSvg: 'assets/appicon/trophy_light.svg',
        trophyLottieJson: 'assets/appicon/trophy_light.json',
        //font
        fightPropIcon: 'assets/fonts/FightProp.ttf',
        font: 'assets/fonts/zh-cn.ttf',
      ),
      Shadows(
          shadow: BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 10,
        spreadRadius: 0.1,
        color: Color.fromARGB(255, 28, 28, 28),
      ))
    ]);

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 205, 179, 124), brightness: Brightness.dark),
    // appBarTheme: AppBarTheme(
    //   // backgroundColor: Color.fromARGB(255, 38, 38, 38),
    //   // foregroundColor: Color.fromRGBO(255, 255, 255, 1),
    //   systemOverlayStyle: SystemUiOverlayStyle(
    //       statusBarBrightness: kIsWeb
    //           ? Brightness.dark
    //           : defaultTargetPlatform == TargetPlatform.iOS
    //               ? Brightness.dark
    //               : Brightness.light,
    //       statusBarIconBrightness: kIsWeb
    //           ? Brightness.dark
    //           : defaultTargetPlatform == TargetPlatform.iOS
    //               ? Brightness.dark
    //               : Brightness.light,
    //       statusBarColor: Colors.transparent,
    //       systemNavigationBarColor: Colors.transparent,
    //       systemNavigationBarIconBrightness: Brightness.light),
    // ),
    textTheme: Typography.englishLike2018.apply(bodyColor: Colors.white),
    extensions: const [
      ThemeAssets(
        //home
        homeIconSvg: 'assets/appicon/homeicon_dark.svg',
        homeLottieJson: 'assets/appicon/homeicon_dark.json',
        //leaderboard
        lbIconSvg: 'assets/appicon/leaderboard_dark.svg',
        lbLottieJson: 'assets/appicon/leaderboard_dark.json',
        //profile
        profileIconSvg: 'assets/appicon/profile_dark.svg',
        profileLottieJson: 'assets/appicon/profile_dark.json',
        //trophy
        trophyIconSvg: 'assets/appicon/trophy_dark.svg',
        trophyLottieJson: 'assets/appicon/trophy_dark.json',
        //font
        fightPropIcon: 'assets/fonts/FightProp.ttf',
        font: 'assets/fonts/zh-cn.ttf',
      ),
      Shadows(
          shadow: BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 8,
        spreadRadius: 0.1,
        color: Color.fromARGB(255, 217, 217, 217),
      ))
    ]);

class ThemeAssets extends ThemeExtension<ThemeAssets> {
  final String homeIconSvg;
  final String homeLottieJson;
  final String lbIconSvg;
  final String lbLottieJson;
  final String profileIconSvg;
  final String profileLottieJson;
  final String trophyIconSvg;
  final String trophyLottieJson;
  final String font;
  final String fightPropIcon;

  const ThemeAssets({
    required this.homeIconSvg,
    required this.homeLottieJson,
    required this.lbIconSvg,
    required this.lbLottieJson,
    required this.profileIconSvg,
    required this.profileLottieJson,
    required this.trophyIconSvg,
    required this.trophyLottieJson,
    required this.font,
    required this.fightPropIcon,
  });

  @override
  ThemeAssets copyWith({
    String? homeIconSvg,
    String? homeLottieJson,
    String? lbIconSvg,
    String? lbLottieJson,
    String? profileIconSvg,
    String? profileLottieJson,
    String? trophyIconSvg,
    String? trophyLottieJson,
    String? font,
    String? fightPropIcon,
  }) {
    return ThemeAssets(
      homeIconSvg: homeIconSvg ?? this.homeIconSvg,
      homeLottieJson: homeLottieJson ?? this.homeLottieJson,
      lbIconSvg: lbIconSvg ?? this.lbIconSvg,
      lbLottieJson: lbLottieJson ?? this.lbLottieJson,
      profileIconSvg: profileIconSvg ?? this.profileIconSvg,
      profileLottieJson: profileLottieJson ?? this.profileLottieJson,
      trophyIconSvg: trophyIconSvg ?? this.trophyIconSvg,
      trophyLottieJson: trophyLottieJson ?? this.trophyLottieJson,
      font: font ?? this.font,
      fightPropIcon: fightPropIcon ?? this.fightPropIcon,
    );
  }

  @override
  ThemeAssets lerp(ThemeExtension<ThemeAssets>? other, double t) {
    return this;
  }
}

class Shadows extends ThemeExtension<Shadows> {
  final BoxShadow shadow;

  const Shadows({required this.shadow});

  @override
  Shadows copyWith({BoxShadow? shadow}) {
    return Shadows(shadow: shadow ?? this.shadow);
  }

  @override
  Shadows lerp(ThemeExtension<Shadows>? other, double t) {
    return this;
  }
}
