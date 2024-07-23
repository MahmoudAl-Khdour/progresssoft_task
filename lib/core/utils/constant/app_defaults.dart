import 'package:flutter/material.dart';

class AppDefaults {
  static const double defaultIconSize = 30.0;

  static const double defaultSidePadding = 20.0;

  static const double defaultTopPadding = 20.0;

  static const double defaultBottomPadding = 40.0;

  static const double defaultRightPadding = 10.0;

  static const double defaultLeftPadding = 10.0;

  static const double defaultLargePadding = 20.0;

  static const double defaultRightRadius = 5.0;

  static const double defaultLeftRadius = 5.0;

  static const double defaultMaxRightRadius = 20.0;

  static const double defaultMaxLeftRadius = 20.0;

  static const double defaultButtonVerticalPadding = 11.0;

  static const double defaultVerticalSpaceBetweenSmallWidget = 5.0;

  static const double defaultHorizontalSpaceBetweenSmallWidget = 5.0;

  static const double defaultHorizontalSpaceBetweenWidget = 10.0;

  static const double defaultVerticalSpaceBetweenWidget = 10.0;

  static const double defaultVerticalSpaceBetweenBigWidget = 25.0;

  static final List<BoxShadow> defaultShadow = [
    BoxShadow(
      color: Colors.grey[400]!.withOpacity(0.1),
      spreadRadius: 0.1,
      blurRadius: 1,
      offset: const Offset(
        0,
        1,
      ),
    ),
    BoxShadow(
      color: Colors.grey[400]!.withOpacity(0.1),
      spreadRadius: 0.1,
      blurRadius: 1,
      offset: const Offset(
        1,
        0,
      ),
    ),
    BoxShadow(
      color: Colors.grey[400]!.withOpacity(0.1),
      spreadRadius: 0.1,
      blurRadius: 1,
      offset: const Offset(
        0,
        -1,
      ),
    ),
    BoxShadow(
      color: Colors.grey[400]!.withOpacity(0.1),
      spreadRadius: 0.1,
      blurRadius: 1,
      offset: const Offset(
        -1,
        0,
      ),
    ),
  ];
}
