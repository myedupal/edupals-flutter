import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class QuestionActionList extends StatelessWidget {
  const QuestionActionList({super.key, this.action});

  final Function(String)? action;

  Widget buttonTemplate({required KeyValue config}) => ImageAssetView(
        fileName: AppAssets().getPath(name: config.key ?? ""),
        width: AppValues.double15,
        height: AppValues.double15,
        color: AppColors.accent500,
      )
          .capsulise(
              radius: 100,
              color: AppColors.accent100,
              padding: const EdgeInsets.all(AppValues.double15))
          .padding(const EdgeInsets.only(bottom: AppValues.double15))
          .onTap(() {
        action?.call(config.label ?? "");
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buttonTemplate(config: KeyValue(label: "back", key: "left_chevron")),
        buttonTemplate(config: KeyValue(label: "flag", key: "flag")),
        buttonTemplate(
            config: KeyValue(label: "flashCard", key: "flash_cards")),
        buttonTemplate(config: KeyValue(label: "next", key: "right_chevron")),
      ],
    );
  }
}
