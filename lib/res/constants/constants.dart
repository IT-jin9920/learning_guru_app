
import 'package:flutter/material.dart';

class AppConstantsSpacing {
  AppConstantsSpacing._();

  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingExtraLarge = 40.0;

  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingExtraLarge = 40.0;

  static const BorderRadius borderRadiusSmall = BorderRadius.all(Radius.circular(8.0));
  static const BorderRadius borderRadiusMedium = BorderRadius.all(Radius.circular(10.0));
  static const BorderRadius borderRadiusLarge = BorderRadius.all(Radius.circular(15.0));

  static const Duration animationDurationShort = Duration(milliseconds: 150);
  static const Duration animationDurationMedium = Duration(milliseconds: 300);
  static const Duration animationDurationLong = Duration(milliseconds: 500);

  static const double radiusLarge = 28.0;

  static const double iconSizeSmall = 18.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;

  static List<BoxShadow> elevation1 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 5,
      offset: const Offset(0, 3),
    ),
  ];

  static List<BoxShadow> elevation2 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 10,
      offset: const Offset(0, 5),
    ),
  ];

}