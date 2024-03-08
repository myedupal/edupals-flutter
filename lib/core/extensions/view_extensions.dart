import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:flutter/material.dart';

extension ExpandedWidget on Widget {
  Widget padding(EdgeInsetsGeometry edge) => Padding(
        padding: edge,
        child: this,
      );

  Widget background(EdgeInsetsGeometry? padding,
          [Color? color = AppColors.gray100]) =>
      Container(
        padding: padding,
        color: color,
        child: this,
      );

  Widget onTap(VoidCallback onClick) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onClick();
        },
        child: this,
      );

  Widget capsulise(
          {EdgeInsetsGeometry? padding,
          double? radius = 100,
          Color? color = AppColors.gray900,
          bool? border = false,
          Color? borderColor = AppColors.gray200,
          double? width,
          double? height,
          Alignment? alignment}) =>
      Container(
          padding: padding,
          width: width,
          height: height,
          alignment: alignment,
          decoration: BoxDecoration(
              border: border ?? true
                  ? Border.all(color: borderColor ?? AppColors.gray100)
                  : null,
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(radius ?? 100))),
          child: this);

  Widget roundedBorder(BorderRadius radius,
          [Color? color = AppColors.gray900]) =>
      Container(
          decoration: BoxDecoration(color: color, borderRadius: radius),
          child: this);

  Widget noSplash(BuildContext context) => Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      child: this);

  Widget constraintsWrapper(
          {double? width,
          double? height,
          Color? color,
          bool isCenter = true}) =>
      Container(
        color: color ?? AppColors.white,
        alignment: isCenter ? Alignment.center : null,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: height ?? double.infinity,
            maxWidth: width ?? double.infinity,
          ),
          child: this,
        ),
      );

  Widget repaintBoundary() => RepaintBoundary(child: this);

  Widget scaffoldWrapper(
          {bool? resizeToAvoidBottomInset = false,
          Color? backgroundColor = AppColors.white,
          bool topSafe = true}) =>
      Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: backgroundColor,
        body: SafeArea(bottom: false, top: topSafe, child: this),
      );

  Widget ignorePointer([bool ignore = false]) =>
      IgnorePointer(ignoring: ignore, child: this);

  Widget addBackgroundImage({bool isDisplay = true}) => isDisplay
      ? Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            image: DecorationImage(
              alignment: Alignment.bottomCenter,
              image: AssetImage(AppAssets.layoutBg),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: this)
      : this;

  Widget addBorder({BorderSide? right}) => Container(
        decoration: BoxDecoration(
          border: Border(right: right ?? const BorderSide()),
        ),
        child: this,
      );

  Widget dialogWrapper(
          {bool withPadding = true, EdgeInsets? customPadding}) =>
      Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 0.0,
          child: padding(withPadding
              ? customPadding ??
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
              : EdgeInsets.zero));
}
