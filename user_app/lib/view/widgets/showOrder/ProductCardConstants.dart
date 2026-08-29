import 'package:flutter/material.dart';

class ProductCardConstants {
  // Container & Card
  static const double cardMarginVertical = 8;
  static const double cardMarginHorizontal = 16;
  static const double cardPadding = 10;
  static const double cardBorderRadius = 16;
  static const double cardBorderWidth = 2;
  static const double cardBorderWidthUnselected = 0.5;
  static const double cardBorderOpacityUnselected = 0.3;
  static const double cardShadowBlurRadius = 8;
  static const double cardShadowOpacity = 0.1;
  static const Offset cardShadowOffset = Offset(0, 4);

  // Image
  static const double imageSize = 80;
  static const double imageBorderRadius = 12;
  static const double imageSpacer = 12;

  // Text - Title
  static const double titleFontSize = 16;
  static const FontWeight titleFontWeight = FontWeight.w600;

  // Text - Price
  static const double priceFontSize = 16;
  static const FontWeight priceFontWeight = FontWeight.bold;

  // Text - Details
  static const double detailsSpacer = 6;

  // Rate Button
  static const double rateButtonSpacer = 12;
  static const double rateButtonPaddingHorizontal = 14;
  static const double rateButtonPaddingVertical = 8;
  static const double rateButtonBorderRadius = 10;
  static const double rateButtonFontSize = 13;

  // Colors
  static const Color errorImageIconColor = Colors.white;
  static const Color rateButtonEvaluatedColor = Colors.green;
  static const Color rateButtonDisabledColor = Colors.green;
}
