import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key, this.message, this.action});

  final String? message;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ImageAssetView(
          fileName: AppAssets.success,
          width: AppValues.double100,
        ),
        Text(
          message ?? "",
          style: MyTextStyle.m.medium,
        ).padding(const EdgeInsets.only(
            top: AppValues.double20, bottom: AppValues.double10)),
        BaseButton(
            fullWidth: true,
            text: "Noted",
            onClick: () {
              if (action == null) {
                Get.back();
              } else {
                action?.call();
              }
            }).padding(const EdgeInsets.only(top: AppValues.double20))
      ],
    ).padding(const EdgeInsets.all(AppValues.double20));
  }
}
