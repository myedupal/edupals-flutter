import 'package:edupals/core/base/model/table_column.dart';
import 'package:edupals/core/components/base_table.dart';
import 'package:edupals/core/components/image_asset_view.dart';
import 'package:edupals/core/extensions/context_extensions.dart';
import 'package:edupals/core/extensions/view_extensions.dart';
import 'package:edupals/core/values/app_assets.dart';
import 'package:edupals/core/values/app_colors.dart';
import 'package:edupals/core/values/app_text_style.dart';
import 'package:edupals/core/values/app_values.dart';
import 'package:edupals/features/history/domain/model/activity.dart';
import 'package:edupals/features/history/presentation/controller/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryTable extends GetView<HistoryController> {
  const HistoryTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => BaseTable<Activity>(
          dataList: controller.activityList.toList(),
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
                      child: Text(
                    "${data.subject?.name}",
                    style: MyTextStyle.xs,
                  ).padding(const EdgeInsets.only(left: AppValues.double10)))
                ],
              ),
            ),
            TableColumn(
              name: "Progress",
              column: (data, index) {
                return Text(
                  "${data.activityQuestionsCount}/${data.questionsCount}",
                  style: MyTextStyle.xs,
                );
              },
            ),
            if (!context.isPhonePortrait) ...[
              TableColumn(name: "Type", selector: "activity_type"),
              TableColumn(name: "Created At", selector: "created_at"),
            ],
            TableColumn(
              name: "Actions",
              column: (data, index) {
                return Row(
                  children: [
                    Text(
                      "Resume",
                      style: MyTextStyle.xxs.bold.c(AppColors.gray600),
                      textAlign: TextAlign.center,
                    )
                        .capsulise(
                            radius: 100,
                            border: true,
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppValues.double15,
                                vertical: AppValues.double5))
                        .onTap(() {
                      // controller.deleteActivity(id: data.id);
                      controller.navigatePage(activity: data);
                    })
                  ],
                );
              },
            ),
          ],
        ));
  }
}
