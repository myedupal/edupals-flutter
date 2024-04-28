import 'package:edupals/core/base/base_button.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    this.title,
    this.subtitle,
    this.action,
    this.buttonText,
    this.secondButtonText,
  });

  final String? title, buttonText, subtitle, secondButtonText;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ImageAssetView(
          fileName: AppAssets.errorLottie,
          width: 60,
          height: 60,
        ),
        Text(
          title ?? "Error",
          style: MyTextStyle.l.bold,
        ).padding(const EdgeInsets.only(
            top: AppValues.double20, bottom: AppValues.double10)),
        Text(
          subtitle ?? "",
          style: MyTextStyle.m,
          textAlign: TextAlign.center,
        ),
        BaseButton(
                text: buttonText ?? "Noted",
                fullWidth: true,
                onClick: () {
                  if (action == null) {
                    Get.back();
                  } else {
                    action?.call();
                  }
                })
            .padding(const EdgeInsets.only(
                top: AppValues.double20, bottom: AppValues.double10)),
      ],
    ).padding(const EdgeInsets.symmetric(horizontal: AppValues.double10));
  }
}
