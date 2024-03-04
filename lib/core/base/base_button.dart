import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String text;
  final ButtonType type;
  final bool enabled;
  final bool fullWidth;
  final VoidCallback onClick;

  const BaseButton(
      {super.key,
      required this.text,
      this.type = ButtonType.primary,
      this.enabled = true,
      this.fullWidth = false,
      required this.onClick});

  Color getButtonColor() {
    Color backgroundColor = AppColors.gray900;
    switch (type) {
      case ButtonType.primary:
        backgroundColor = AppColors.accent500;
        break;
      case ButtonType.error:
        backgroundColor = AppColors.red600;
        break;
      case ButtonType.secondary:
        backgroundColor = AppColors.gray900;
        break;
      case ButtonType.white:
        backgroundColor = AppColors.white;
        break;
      case ButtonType.gray:
        backgroundColor = AppColors.gray100;
        break;
    }
    return backgroundColor;
  }

  Color getTextColor() {
    Color backgroundColor = AppColors.gray900;
    switch (type) {
      case ButtonType.primary:
        backgroundColor = AppColors.white;
        break;
      case ButtonType.error:
        backgroundColor = AppColors.white;
        break;
      case ButtonType.secondary:
        backgroundColor = AppColors.white;
        break;
      case ButtonType.white:
        backgroundColor = AppColors.gray900;
        break;
      case ButtonType.gray:
        backgroundColor = AppColors.gray900;
        break;
    }
    return backgroundColor;
  }

  Widget _buttonBody() {
    final ButtonStyle style = ElevatedButton.styleFrom(
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 18),
        splashFactory: InkRipple.splashFactory,
        backgroundColor: getButtonColor());

    return ElevatedButton(
        onPressed: enabled
            ? () {
                onClick();
              }
            : null,
        style: style,
        child: Text(text.toUpperCase(),
            style: MyTextStyle.xxs.bold.c(getTextColor())));
  }

  @override
  Widget build(BuildContext context) {
    return fullWidth
        ? ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
            ),
            child: _buttonBody())
        : _buttonBody();
  }
}

enum ButtonType { primary, secondary, white, gray, error }