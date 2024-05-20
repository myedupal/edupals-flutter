import 'package:edupals/core/components/error_dialog.dart';
import 'package:edupals/core/components/success_dialog.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseDialog {
  static showError(
      {String? subtitle,
      String? title,
      VoidCallback? action,
      String? buttonText}) {
    Get.dialog(
      ErrorDialog(
        title: title,
        subtitle: subtitle,
        action: action,
        buttonText: buttonText,
      ).constraintsWrapper(width: 400, isCenter: false).dialogWrapper(),
    );
  }

  static showSuccess(
      {String? message,
      bool dismissable = true,
      VoidCallback? action,
      String? buttonText}) {
    Get.dialog(
        barrierDismissible: dismissable,
        SuccessDialog(
          message: message,
          action: action,
          buttonText: buttonText,
        ).constraintsWrapper(width: 400, isCenter: false).dialogWrapper());
  }

  static customise(
      {required Widget child,
      bool dismissable = true,
      isBase = false,
      double maxWidth = 600}) {
    Get.dialog(
        barrierDismissible: dismissable,
        isBase
            ? child
            : child
                .constraintsWrapper(width: maxWidth, isCenter: false)
                .dialogWrapper());
  }
}
