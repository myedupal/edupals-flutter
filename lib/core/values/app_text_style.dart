import 'package:flutter/material.dart';

class BaseTextStyle extends TextStyle {
  const BaseTextStyle({
    FontWeight? fontWeight,
    double? fontSize,
    double? height,
    String fontFamily = 'Figtree',
    TextDecoration decoration = TextDecoration.none,
  }) : super(
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: fontSize ?? 16.0,
          height: height ?? 1.5,
          leadingDistribution: TextLeadingDistribution.even,
          decoration: decoration,
          fontFamily: fontFamily,
          letterSpacing: 0,
        );
}

enum MyFontWeight { regular, medium, bold, semibold, extraBold }

class MyTextStyle {
  static const FontWeight fontWeight = FontWeight.w400;

  static const TextStyle xl5 = BaseTextStyle(
    fontSize: 42,
    fontWeight: fontWeight,
  );
  static const TextStyle xl2 = BaseTextStyle(
    fontSize: 32,
    fontWeight: fontWeight,
  );
  static const TextStyle xl1 = BaseTextStyle(
    fontSize: 28,
    fontWeight: fontWeight,
  );
  static const TextStyle xxxl = BaseTextStyle(
    fontSize: 24,
    fontWeight: fontWeight,
  );
  static const TextStyle xxl = BaseTextStyle(
    fontSize: 22,
    fontWeight: fontWeight,
  );
  static const TextStyle xl = BaseTextStyle(
    fontSize: 20,
    fontWeight: fontWeight,
  );
  static const TextStyle l = BaseTextStyle(
    fontSize: 18,
    fontWeight: fontWeight,
  );
  static const TextStyle m = BaseTextStyle(
    fontSize: 16,
    fontWeight: fontWeight,
  );
  static const TextStyle s = BaseTextStyle(
    fontSize: 14,
    fontWeight: fontWeight,
  );
  static const TextStyle xs = BaseTextStyle(
    fontSize: 12,
    fontWeight: fontWeight,
  );
  static const TextStyle xxs = BaseTextStyle(
    fontSize: 10,
  );
}

// 10,12,16,18,24,36
// 10,12,(14,16),18,20,22,24
// xxs,xs,s,m,l,xl,xxl,xxxl
// Extension to help add params in TextStyle
extension TextStyleHelpers on TextStyle {
  TextStyle c(Color value) => copyWith(color: value);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
  TextStyle h(double value) => copyWith(height: value);
}
