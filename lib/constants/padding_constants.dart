import 'package:flutter/material.dart';

mixin PaddingConstants {
  EdgeInsets buildDefaultSymetricPadding(BuildContext context) =>
      EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02,
          vertical: MediaQuery.of(context).size.height * 0.02);

  EdgeInsets buildDefaultSymetricVerticalPadding(BuildContext context) =>
      EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02);

  EdgeInsets get defaultPadding => const EdgeInsets.all(10.0);

  EdgeInsets buildDefaultSymetricHorizontalPadding(BuildContext context) =>
      EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * 0.01);

  double bottomSheetWidth(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.75;
  }

  double managmentTabBarIconWidth(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.015;
  }

  double bottomSheetHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.25;

  EdgeInsets appBarActinonsPadding(BuildContext context) =>
      EdgeInsets.all(MediaQuery.of(context).size.height * 0.015);

  EdgeInsets get loginFailDialogContentPadding => const EdgeInsets.all(10);

  double spacingHigh(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.03;

  double spacingMid(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.02;

  double spacingLow(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.01;

  double spacingDeepLow(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.005;

  double circleAvatarRadiusHigh(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.15;

  double get profileViewAvatarSize => 28;

  double get discoverPostsAvatarSize => 20;
  // double x = MediaQuery.of(context).size.height / 28;
}
