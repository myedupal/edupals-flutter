import 'package:edupals/core/base/model/key_value.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/list_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';

class SelectionInput extends StatelessWidget {
  const SelectionInput(
      {super.key,
      this.label,
      this.dataList,
      this.data,
      this.onRemove,
      this.isMultiSelect = false,
      this.isRequired = false});

  final List<KeyValue>? dataList;
  final KeyValue? data;
  final String? label;
  final Function(String id)? onRemove;
  final bool isMultiSelect;
  final bool isRequired;

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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          label ?? "",
                          style: MyTextStyle.xs.h(0).c(AppColors.gray600),
                        ),
                        if (isRequired)
                          Text(
                            "*",
                            style: MyTextStyle.xs.h(0).c(AppColors.red600),
                          )
                      ],
                    ),
                  if (isMultiSelect)
                    dataList?.isEmpty == true
                        ? Text("",
                            style: MyTextStyle.s.medium.c(AppColors.gray900))
                        : Wrap(
                            spacing: 5, // gap between adjacent chips
                            runSpacing: 5, // gap between lines
                            children: <Widget>[
                              ...?dataList?.mapIndexed((index, item) => Row(
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
                  else
                    Text(data != null ? data?.label ?? "" : "",
                        style: MyTextStyle.s.medium.c(AppColors.gray900))
                ])),
            const ImageAssetView(fileName: AppAssets.downChevronFill)
          ],
        ));
  }
}
