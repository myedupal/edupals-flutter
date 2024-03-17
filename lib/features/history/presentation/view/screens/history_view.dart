import 'package:edupals/core/base/model/table_column.dart';
import 'package:edupals/core/components/base_table.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/history/domain/model/activity.dart';
import 'package:edupals/features/question-bank/presentation/view/components/treding_column.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  Widget get topicsSection => Container(
        margin: const EdgeInsets.only(top: AppValues.double20),
        height: 120,
        child: ListView(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              children: [
                for (int i = 0; i < 10; i++)
                  SizedBox(
                    width: Get.width * 0.3,
                    child: const TrendingColumn().padding(
                        const EdgeInsets.only(right: AppValues.double20)),
                  )
              ],
            )
          ],
        ),
      );

  Widget get historyBody => BaseTable<Activity>(
        column: [
          TableColumn(
            name: "Past Activity",
            ableSort: true,
            expanded: true,
            column: (data, index) => Row(
              children: [
                const ImageAssetView(
                  fileName: AppAssets.history,
                  width: AppValues.double15,
                  height: AppValues.double15,
                ).capsulise(
                    radius: 100,
                    color: AppColors.gray100,
                    padding: const EdgeInsets.all(AppValues.double10)),
                Expanded(
                    child: const Text(
                  "Mathematics",
                  style: MyTextStyle.xs,
                ).padding(const EdgeInsets.only(left: AppValues.double10)))
              ],
            ),
          ),
          TableColumn(
            name: "Progress",
            column: (data, index) {
              return const Text(
                "100/100",
                style: MyTextStyle.xs,
              );
            },
          ),
          TableColumn(
            name: "Type",
          ),
          TableColumn(
            name: "Created At",
          ),
          TableColumn(
            name: "Actions",
            column: (data, index) {
              return Row(
                children: [
                  Text(
                    "Resume",
                    style: MyTextStyle.xxs.bold,
                    textAlign: TextAlign.center,
                  ).capsulise(
                      radius: 100,
                      border: true,
                      borderColor: AppColors.gray500,
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppValues.double15,
                          vertical: AppValues.double5))
                ],
              );
            },
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Activity",
          style: MyTextStyle.xl1.bold,
        ),
        topicsSection
            .padding(const EdgeInsets.only(bottom: AppValues.double20)),
        historyBody
      ],
    )
        .padding(const EdgeInsets.only(right: AppValues.double40))
        .padding(const EdgeInsets.symmetric(horizontal: AppValues.double20));
  }
}
