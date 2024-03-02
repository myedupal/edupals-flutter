import 'package:edupals/core/base/key_value.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/list_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class SelectionInput extends StatelessWidget {
  const SelectionInput({super.key, this.label, this.data, this.onRemove});

  final List<KeyValue>? data;
  final String? label;
  final Function(String id)? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppValues.double12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray300),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  if (label?.isNotEmpty == true)
                    Text(
                      label ?? "",
                      style: MyTextStyle.xs.h(0).c(AppColors.gray600),
                    ),
                  (data?.length ?? 0) < 2
                      ? Text(data?.first.label ?? "",
                          style: MyTextStyle.s.medium.c(AppColors.gray900))
                      : Wrap(
                          spacing: 5, // gap between adjacent chips
                          runSpacing: 5, // gap between lines
                          children: <Widget>[
                            ...?data?.mapIndexed((index, item) => Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      item.label ?? "",
                                      style: MyTextStyle.xxs.bold
                                          .c(AppColors.accent500),
                                    ),
                                    const ImageAssetView(
                                            fileName: AppAssets.cross)
                                        .padding(const EdgeInsets.only(
                                            left: AppValues.double5))
                                  ],
                                )
                                    .capsulise(
                                        radius: 100,
                                        color: AppColors.accent100,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: AppValues.double2,
                                            horizontal: AppValues.double10))
                                    .padding(const EdgeInsets.only(
                                        top: AppValues.double5))
                                    .onTap(() {
                                  onRemove?.call(item.key ?? "");
                                }))
                          ],
                        )
                ])),
            const ImageAssetView(fileName: AppAssets.downChevronFill)
          ],
        ));
  }
}
