import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoDataView extends StatelessWidget {
  const NoDataView({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageAssetView(
            fileName: AppAssets.noDataLottie,
            width: Get.dynamicWidth * 0.25,
          ),
          Text(
            message ?? "",
            style: MyTextStyle.l.bold,
            textAlign: TextAlign.center,
          ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double40)),
          BaseButton(
              text: "Go Back",
              onClick: () {
                Get.back();
              }).padding(const EdgeInsets.only(top: AppValues.double20))
        ],
      ),
    );
  }
}
