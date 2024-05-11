import 'package:edupals/core/base/base_divider.dart';
import 'package:edupals/core/base/model/table_column.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/extensions/string_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseTable<T extends TableConvertible> extends StatelessWidget {
  const BaseTable({super.key, this.column, this.dataList});

  final List<TableColumn<T>>? column;
  final List<T>? dataList;

  Widget bodyWrapper(Widget Function(TableColumn<T>) widget) {
    return Row(children: [
      ...?column?.map((e) => Expanded(
          flex: e.expanded
              ? (column?.length ?? 1)
              : Get.context?.isPhonePortrait == true
                  ? 2
                  : 1,
          child: widget.call(e)))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      children: [
        bodyWrapper((e) => Row(
              children: [
                Text(
                  "${e.name}",
                  style: MyTextStyle.xs,
                ),
                if (e.ableSort)
                  const ImageAssetView(
                    fileName: AppAssets.sortFull,
                    width: AppValues.double8,
                  )
                      .capsulise(
                          color: AppColors.gray100,
                          padding: const EdgeInsets.all(AppValues.double8))
                      .padding(const EdgeInsets.only(left: AppValues.double10))
              ],
            )).padding(const EdgeInsets.all(AppValues.double5)),
        const BaseDivider(),
        Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: dataList?.length,
                itemBuilder: (context, dataIndex) {
                  return Column(
                    children: [
                      IntrinsicHeight(
                          child: bodyWrapper(
                        (e) => (e.column
                                    ?.call(dataList![dataIndex], dataIndex) ??
                                Text(
                                  dataList?[dataIndex]
                                          .toTable()[e.selector]
                                          .toString()
                                          .toCapitalized() ??
                                      "",
                                  style: MyTextStyle.xs,
                                ))
                            .padding(const EdgeInsets.all(AppValues.double5)),
                      )),
                      const BaseDivider()
                    ],
                  );
                }))
      ],
    ));
  }
}
