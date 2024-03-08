import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseDialog {
  static showError({String? subtitle, String? title}) {
    Get.dialog(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ImageAssetView(
            fileName: AppAssets.errorLottie,
            width: 60,
            height: 60,
          ),
          Text(
            "Error",
            style: MyTextStyle.l.bold,
          ).padding(const EdgeInsets.only(
              top: AppValues.double20, bottom: AppValues.double10)),
          Text(
            subtitle ?? "",
            style: MyTextStyle.m,
          ),
          BaseButton(
                  text: "Noted",
                  fullWidth: true,
                  onClick: () {
                    Get.back();
                  })
              .padding(const EdgeInsets.only(
                  top: AppValues.double20, bottom: AppValues.double10))
        ],
      )
          .padding(const EdgeInsets.symmetric(horizontal: AppValues.double30))
          .constraintsWrapper(500)
          .dialogWrapper(),
    );
  }
}
